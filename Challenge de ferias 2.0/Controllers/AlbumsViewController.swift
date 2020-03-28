//
//  AlbumsViewController.swift
//  Challenge de ferias 2.0
//
//  Created by Pedro Henrique Guedes Silveira on 17/07/19.
//  Copyright © 2019 Pedro Henrique Guedes Silveira. All rights reserved.
//

import UIKit
import Foundation
import CloudKit



class AlbumsViewController: UIViewController, DataModifiedDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource {
   
    
    var albumPhotos:[PhotoCard] = []
    var albums:[CKRecord] = []
    var currentAlbum:Album?
    var albumPhotoPath: IndexPath?
    var cloudKitController = CloudKitController.self

    @IBOutlet weak var photosCollectionView: UICollectionView!
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var mainImage: UIImageView!

    let dF:DateFormatter = DateFormatter()
    
    func DataModified() {
        getData()
        photosCollectionView.reloadData()
    }
    
    private func getData(){
//        cloudKitController.shared.fetch(recordID: Album().record.recordID, on: .privateDB) { (result) in
//            switch result {
//                
//            case .success(let photo):
//                self.albums.append(contentsOf: photo)
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }     
    }
    
    
    
    private let cellReuseIdentifier = "photoCell"
    private var sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    
    
    private let itemsPerRow: CGFloat = 3

    
    override func viewDidLoad() {
        super.viewDidLoad()
        photosCollectionView.dataSource = self
        photosCollectionView.delegate = self
        ModelManager.shared().addDelegate(newDelegate: self)
        getData()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        var numberOfPhotos:Int?
        
        if let currentAlbum = currentAlbum{
        let quantityOfPhotos = currentAlbum.albumPhotos.count
        numberOfPhotos = quantityOfPhotos
        }
        return numberOfPhotos!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = self.photosCollectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! PhotoCollectionViewCell
        
        if let currentAlbum = currentAlbum{
            let currentPhotos = currentAlbum.albumPhotos
            let currentPhoto = currentPhotos[indexPath.item] 
            cell.photoImageView.image = currentPhoto
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath == albumPhotoPath{
            var size = collectionView.bounds.size
            size.height -= (sectionInsets.top + sectionInsets.bottom)
            size.width -= (sectionInsets.left + sectionInsets.right)
            let ratio = (size.height - view.frame.height) > (size.width - view.frame.width) ? (size.width - view.frame.width) : (size.height - view.frame.height)
            return CGSize(width: view.frame.width - ratio, height: view.frame.height - ratio)
        }
        
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let avaitableWidth = view.frame.width - paddingSpace
        let widthPerItem = avaitableWidth/itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.barTintColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        var imagesPath:[String] = []
        var mainImagePath:String?
        
        
        
        if let currentAlbum = currentAlbum{
            mainImage.image = currentAlbum.albumPhotos[0]
        }
        
        if let currentAlbum = currentAlbum{
            dF.dateFormat = "dd-MM-yy hh:mm"
            lblDate.text = dF.string(from: currentAlbum.setedDate)
            lblName.text = currentAlbum.setedName
        }
        else{
            navigationItem.title = "Error"
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navController = segue.destination as? UINavigationController else {return}
        guard let controller = navController.topViewController as? AlbumsCreatorViewController else {return}
        controller.currentAlbum = currentAlbum
        controller.navigationItem.title = "Editar Album"
        navController.navigationItem.rightBarButtonItem?.title = "Save"
    }
    
    
    
}
