//
//  AlbumsCreatorViewController.swift
//  Challenge de ferias 2.0
//
//  Created by Pedro Henrique Guedes Silveira on 17/07/19.
//  Copyright © 2019 Pedro Henrique Guedes Silveira. All rights reserved.
//

import UIKit

class AlbumsCreatorViewController: UIViewController, UITextFieldDelegate {

    
    var currentAlbum:PhotoAlbum?
    var createdAlbum:PhotoAlbum? = nil
    var albumPhotos:[PhotoCard] = []
    var albumPhoto:PhotoCard?
    
    @IBOutlet weak var txtFieldName: UITextField!
    @IBOutlet weak var photosCountlbl: UILabel!
    @IBOutlet weak var btnDone: UIBarButtonItem!
    @IBOutlet weak var lastImage: UIImageView!
    
    private var imgChanged:Bool = false
    var imgPicker:ImagePicker!
    var myImages:[UIImage] = []
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    override func viewDidLoad() {
        
        txtFieldName.delegate = self

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
   
    @IBAction func editionChanged(_ sender: UITextField) {
        if(sender.text?.count == 1){
            if sender.text == " "{
                sender.text = ""
                return
            }
        }
        
        guard let name = txtFieldName.text, name != ""
            else{
                btnDone.isEnabled = false
                return
        }
        btnDone.isEnabled = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        var teste:Bool = false
        
        if let alb = currentAlbum{
            btnDone.isEnabled = true
            txtFieldName.text = alb.name
            datePicker.date = alb.date! as Date
        }
        if let photoCard = albumPhoto{
            teste = true
            print(teste)
            if let path = photoCard.photoPath{
                let answer:String? = ImagesControl.getFile(filePathWithoutExtension: path)
                if let answer = answer{
                    lastImage.image = UIImage(contentsOfFile: answer)
                    myImages.append(lastImage.image!)
                    albumPhotos.append(photoCard)
                }
            }
        }
    }

    
    @IBAction func photoSelector(_ sender: UIButton) {
            imgPicker = ImagePicker()
            imgPicker.pickImage(self) { (image) in
                self.lastImage.image = image
                self.myImages.append(self.lastImage.image!)
                self.photosCountlbl.text = "\(self.myImages.count)"
                self.imgChanged = true
            }
    }

    @IBAction func btnCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }


    @IBAction func btnDone(_ sender: Any) {
        
        var newPhotos:[UIImage]? = []
        
        if(imgChanged){
            
            for i in 0...myImages.count - 1{
                newPhotos?.append(myImages[i])
            }
            

        }

        if let album = currentAlbum{
            let albumStatus:ModelStatus = ModelManager.shared().editAlbum(target: album, newName: txtFieldName.text, newDate: datePicker.date as NSDate)
            if(!albumStatus.successful){
                fatalError(albumStatus.description)
            }
        }
        else{
            let albumStatus:ModelStatus = ModelManager.shared().addAlbum(name: txtFieldName.text!, date: datePicker!.date as NSDate)
            print(albumPhotos.count)
            if (!albumStatus.successful){
                fatalError(albumStatus.description)
            }
            for i in 0...newPhotos!.count - 1{
                let photoStatus:ModelStatus = ModelManager.shared().addPhoto(target: albumStatus.albumIdentifier!, photo: newPhotos![i])
                if (!photoStatus.successful){
                    fatalError(albumStatus.description)
                }

            }


            
        }
        self.dismiss(animated: true, completion: nil)

    }
}
