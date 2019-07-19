//
//  AlbumsViewController.swift
//  Challenge de ferias 2.0
//
//  Created by Pedro Henrique Guedes Silveira on 17/07/19.
//  Copyright © 2019 Pedro Henrique Guedes Silveira. All rights reserved.
//

import UIKit

//enum PhotoType {
//    case primeiraOpcao
//    case segundaOpcao
//    case terceiraOpcao
//}

class AlbumsViewController: UIViewController {

    
    var currentAlbum:PhotoAlbum?

//    var selectedType: PhotoType = .primeiraOpcao
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    var myImages:[UIImage] = []
    let dF:DateFormatter = DateFormatter()
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.barTintColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
        if let way = currentAlbum?.completePhoto{
            for i in 0...way.count - 1{
                guard let path = way[i] as? PhotoCard else {return}
                if let myPath = path.photoPath{
                    let answer:String? = ImagesControl.getFile(filePathWithoutExtension: myPath)
                    if let answer = answer, let images = UIImage(contentsOfFile: answer){
                        myImages.append(images)
                        mainImage.image = myImages[0]
                    }
                }
            }
        }
        
        var images:[UIImage] = []
        var imagesPath:[String] = []
        guard let currAlbum = currentAlbum else { return }
        guard let completePhoto = currAlbum.completePhoto else { return }
        for i in 0...completePhoto.count - 1 {
            if let photoNumber = currentAlbum?.completePhoto![i]{
                guard let photoPath = photoNumber as? PhotoCard else {return}
                guard let currentPhotoPath = photoPath.photoPath else {return}
                imagesPath.append(currentPhotoPath)
                for i in 0...imagesPath.count - 1{
                    let currentImage:UIImage = UIImage(contentsOfFile: imagesPath[i])!
                    images.append(currentImage)
                }
            }
        }
        
        
        if let currentAlbum = currentAlbum{
            dF.dateFormat = "dd-MM-yy hh:mm"
            lblDate.text = dF.string(from: currentAlbum.date! as Date)
            lblName.text = currentAlbum.name
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navController = segue.destination as? UINavigationController else {return}
        guard let controller = navController.topViewController as? AlbumsCreatorViewController else {return}
        controller.currentAlbum = currentAlbum
        controller.navigationItem.title = "Editar Album"
        navController.navigationItem.rightBarButtonItem?.title = "Save"
    }
    
}
