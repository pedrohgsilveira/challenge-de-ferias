//
//  InsideAlbunsCollectionViewController.swift
//  Challenge de ferias 2.0
//
//  Created by Pedro Henrique Guedes Silveira on 18/07/19.
//  Copyright © 2019 Pedro Henrique Guedes Silveira. All rights reserved.
//
//import Foundation
//import UIKit
//
//private let reuseIdentifier = "Cell"
//
//class InsideAlbunsCollectionViewController: UIViewController, UICollectionViewDelegateFlowLayout, DataModifiedDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
//    
//    private var albumPhotos:[PhotoCard] = []
//    private var currentAlbum:PhotoAlbum?
//    var albumPhotoPath: IndexPath?
//    
//    @IBOutlet weak var photosColletionView: UICollectionView!
//    
//    
//    
//    
//    func DataModified() {
//        photosColletionView.reloadData()
//        getData()
//    }
//    
//    private func getData(){
//        albumPhotos = ModelManager.shared().completePhoto
//
//    }
//    
//    private let cellReuseIdentifier = "photoCell"
//    private var sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
//    
//    private let itemsPerRow: CGFloat = 1
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        photosColletionView.dataSource = self
//        photosColletionView.delegate = self
//        ModelManager.shared().addDelegate(newDelegate: self)
//        getData()
//        
//    }
//    
//    
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
//
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return albumPhotos.count > 6 ? 7 : albumPhotos.count
//    }
//    
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        
//        let cell = self.photosColletionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! PhotoCollectionViewCell
//        var imagesPath:[String] = []
//        
//        if let currentAlbum = currentAlbum{
//            for i in currentAlbum.completePhoto?.array as! [PhotoCard]{
//                imagesPath.append(i.photoPath!)
//            }
//
//            for i in 0...imagesPath.count - 1{
//                let answer:String? = ImagesControl.getFile(filePathWithoutExtension: imagesPath[i])
//                if let answer = answer{
//                    cell.photoImageView.image = UIImage(contentsOfFile: answer)
//                }
//
//            }
//        }
//        if let currentAlbum = currentAlbum{
//            let currentPhoto = albumPhotos[indexPath.row]
//            if let path = currentPhoto.photoPath{
//                let answer:String? = ImagesControl.getFile(filePathWithoutExtension: path)
//                if let answer = answer{
//                    cell.photoImageView.image = UIImage(contentsOfFile: answer)
//                }
//            }
//        }
//        
//        return cell
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        
//        if indexPath == albumPhotoPath{
//            var size = collectionView.bounds.size
//            size.height -= (sectionInsets.top + sectionInsets.bottom)
//            size.width -= (sectionInsets.left + sectionInsets.right)
//            let ratio = (size.height - view.frame.height) > (size.width - view.frame.width) ? (size.width - view.frame.width) : (size.height - view.frame.height)
//            return CGSize(width: view.frame.width - ratio, height: view.frame.height - ratio)
//        }
//        
//        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
//        let avaitableWidth = view.frame.width - paddingSpace
//        let widthPerItem = avaitableWidth/itemsPerRow
//        
//        return CGSize(width: widthPerItem, height: widthPerItem)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return sectionInsets
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return sectionInsets.left
//    }
//    
//
//}
