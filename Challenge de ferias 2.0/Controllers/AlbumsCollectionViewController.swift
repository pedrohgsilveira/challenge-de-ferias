//
//  AlbumsCollectionViewController.swift
//  Challenge de ferias 2.0
//
//  Created by Pedro Henrique Guedes Silveira on 16/07/19.
//  Copyright © 2019 Pedro Henrique Guedes Silveira. All rights reserved.
//

import UIKit


class AlbumsCollectionViewController: UIViewController, UICollectionViewDelegateFlowLayout, DataModifiedDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
//    private var coverPhotos:[PhotoCard] = []
    private var albums:[PhotoAlbum] = []
    var albumPath:IndexPath?
    var coverPhotos:[UIImage] = []
    
    @IBOutlet weak var albumsColletionVIew: UICollectionView!
    
    func DataModified() {
        albumsColletionVIew.reloadData()
        getData()
    }
    
    private func getData(){
//        coverPhotos = ModelManager.shared().completePhoto
        albums = ModelManager.shared().albuns
    }
    
    private let reuseIdentifier = "AlbumCell"
    private let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    private let itemPerRow: CGFloat = 1
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        albumsColletionVIew.dataSource = self
        albumsColletionVIew.delegate = self
        ModelManager.shared().addDelegate(newDelegate: self)
        getData()

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
        cell.albumNamelbl.text = currentAlbum.name
        let numberOfPhotos:Int = cell.photoCardsColletion.count
        for i in 0...numberOfPhotos - 1{
            if let photoCardColletion = cell.photoCardsColletion[i].image{
                coverPhotos[i] = photoCardColletion
            }
        }
        if let way = currentAlbum.completePhoto, way.count > 0{
            for i in 0...way.count - 1{
                if let path = way[i] as? PhotoCard{
                    if let photoPath = path.photoPath{
                        let answer:String? = ImagesControl.getFile(filePathWithoutExtension: photoPath)
                        if let answer = answer, let images = UIImage(contentsOfFile: answer){
                            for _ in 0...numberOfPhotos - 1{
                                coverPhotos.append(images)
                            }
                        }
                    }
                }
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath == albumPath{
            var size = collectionView.bounds.size
            size.height -= (sectionInsets.top + sectionInsets.bottom)
            size.width -= (sectionInsets.left + sectionInsets.right)
            let ratio = (size.height - view.frame.height) > (size.width - view.frame.width) ? (size.width - view.frame.width) : (size.height - view.frame.height)
            return CGSize(width: view.frame.width - ratio, height: view.frame.height - ratio)
        }
        
        let paddingSpace = sectionInsets.left * (itemPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    


}
