//
//  AlbumsCollectionViewController.swift
//  Challenge de ferias 2.0
//
//  Created by Pedro Henrique Guedes Silveira on 16/07/19.
//  Copyright © 2019 Pedro Henrique Guedes Silveira. All rights reserved.
//

import UIKit


class AlbumsCollectionViewController: UIViewController, UICollectionViewDelegateFlowLayout, DataModifiedDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    private var coreDataAlbums:[PhotoAlbum] = []
    private var albums: [Album] = []
    private var albumInteractor = AlbumIteractor.self
    var albumPath:IndexPath?
    private var viwerController:AlbumsViewController?
    var index:Int?
    
    @IBOutlet weak var albumsColletionVIew: UICollectionView!
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? AlbumsViewController{
                viwerController = controller
            if let index = index {

                viwerController?.currentAlbum = albums[index]
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        index = indexPath.item
        self.performSegue(withIdentifier: "Show Album", sender: indexPath.item)
    }
    
    
    
    func DataModified() {
        albumsColletionVIew.reloadData()
        getData()
    }
    
    private func getData(){
        albumInteractor.shared.fetch { [weak self](fetchedAlbums) in
            guard let fetchedAlbums = fetchedAlbums  else {
                return
            }
            self?.albums = fetchedAlbums
        }
    }
    
    private let reuseIdentifier = "AlbumCell"
    private let sectionInsets = UIEdgeInsets(top: 30.0, left: 10.0, bottom: 30.0, right: 10.0)
    private let itemPerRow: CGFloat = 1
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        albumsColletionVIew.dataSource = self
        albumsColletionVIew.delegate = self
        ModelManager.shared().addDelegate(newDelegate: self)
        getData()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        //...
    }


    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albums.count > 6 ? 7 : albums.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.albumsColletionVIew.dequeueReusableCell(withReuseIdentifier: "AlbumCell", for: indexPath) as! AlbumsCollectionViewCell
        let currentAlbum = albums[indexPath.row]
        cell.albumNamelbl.text = currentAlbum.setedName
        
        var contadorImagens:Int = 0
        for photo in currentAlbum.albumPhotos {
                cell.photoCardsColletion[contadorImagens].image = photo
                contadorImagens += 1
                if contadorImagens == 5{
                    break
                }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.bounds.size
        let paddingSpace = sectionInsets.left * (itemPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemPerRow
        let heightPerItem = size.height / 4 + sectionInsets.top * 2.5
        
        return CGSize(width: widthPerItem, height: heightPerItem)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
    @objc func onPan(indexPath: IndexPath){
        let status:ModelStatus = ModelManager.shared().removeAlbum(rA: indexPath.row)
        albumsColletionVIew.reloadData()
        
        
    }
}
