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

    let dF:DateFormatter = DateFormatter()
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.barTintColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        var myImagesPath:[String] = []
//        var firstImagePath:String?
//
//        for i in currentAlbum?.completePhoto?.array as! [PhotoCard] {
//            myImagesPath.append(i.photoPath!)
//        }
//        firstImagePath = myImagesPath[0]
//
//        if let firstImagesPath = firstImagePath{
//            let answer:String? = ImagesControl.getFile(filePathWithoutExtension: firstImagesPath)
//            if let answer = answer{
//                mainImage.image = UIImage(contentsOfFile: answer)
//            }
//        }
        
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
