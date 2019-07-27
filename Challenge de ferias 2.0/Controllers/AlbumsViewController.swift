//
//  AlbumsViewController.swift
//  Challenge de ferias 2.0
//
//  Created by Pedro Henrique Guedes Silveira on 17/07/19.
//  Copyright © 2019 Pedro Henrique Guedes Silveira. All rights reserved.
//

import UIKit
import Foundation

//enum PhotoType {
//    case primeiraOpcao
//    case segundaOpcao
//    case terceiraOpcao
//}

class AlbumsViewController: UIViewController, DataModifiedDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource {
   
    
    var albumPhotos:[PhotoCard] = []
    var albums:[PhotoAlbum] = []
    var currentAlbum:PhotoAlbum?
    var albumPhotoPath: IndexPath?

//    var selectedType: PhotoType = .primeiraOpcao
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
        albumPhotos = ModelManager.shared().completePhoto
        albums = ModelManager.shared().albuns
        
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
            if let quantityOfPhotos = currentAlbum.completePhoto?.count{
                numberOfPhotos = quantityOfPhotos
            }
        }
        return numberOfPhotos!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
//        var imagesPaths:[String] = []
        
        let cell = self.photosCollectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! PhotoCollectionViewCell
        
        if let currentAlbum = currentAlbum{
            let currentPhotos = currentAlbum.completePhoto
            let currentPhoto = currentPhotos![indexPath.item] as? PhotoCard
            let answer:String? = ImagesControl.getFile(filePathWithoutExtension: currentPhoto!.photoPath!)
            if let answer = answer{
                cell.photoImageView.image = UIImage(contentsOfFile: answer)
            }
        }
        
        
//        let currentPhoto = albumPhotos[indexPath.row]
//        let answer:String? = ImagesControl.getFile(filePathWithoutExtension: currentPhoto.photoPath!)
//        if let answer = answer{
//            cell.photoImageView.image = UIImage(contentsOfFile: answer)
//
//        }
//        if let currentAlbum = currentAlbum{
//            if let way = currentAlbum.completePhoto, way.count>0{
//                for i in 0...way.count - 1{
//                    if let path = way[i] as? PhotoCard{
//                        if let photoPath = path.photoPath{
//                            let answer:String? = ImagesControl.getFile(filePathWithoutExtension: photoPath)
//                            if let answer = answer{
//                                imagesPaths.append(answer)
//                            }
//                        }
//                    }
//                }
//            }
//
//            let imagePath = imagesPaths[indexPath.row]
//
//            cell.photoImageView.image = UIImage(contentsOfFile: imagePath)
//
//
//        }
        
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
            for i in currentAlbum.completePhoto?.array as! [PhotoCard]{
                imagesPath.append(i.photoPath!)
            }
            
            mainImagePath = imagesPath[0]
            
            if let mainImagePath = mainImagePath{
                let answer:String? = ImagesControl.getFile(filePathWithoutExtension: mainImagePath)
                if let answer = answer{
                    mainImage.image = UIImage(contentsOfFile: answer)
                }
            }
        }
        
        if let currentAlbum = currentAlbum{
            dF.dateFormat = "dd-MM-yy hh:mm"
            lblDate.text = dF.string(from: currentAlbum.date! as Date)
            lblName.text = currentAlbum.name
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
