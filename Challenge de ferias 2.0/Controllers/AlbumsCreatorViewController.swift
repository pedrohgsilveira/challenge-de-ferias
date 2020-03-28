//
//  AlbumsCreatorViewController.swift
//  Challenge de ferias 2.0
//
//  Created by Pedro Henrique Guedes Silveira on 17/07/19.
//  Copyright © 2019 Pedro Henrique Guedes Silveira. All rights reserved.
//

import UIKit

class AlbumsCreatorViewController: UIViewController, UITextFieldDelegate {

    
    var currentAlbum:Album?
    var createdAlbum:Album? = nil
    var albumPhotos:[Photo] = []
    var albumPhoto:Photo?
    let cloudKitControler = CloudKitController.self

    
    @IBOutlet weak var txtFieldName: UITextField!
    @IBOutlet weak var photosCountlbl: UILabel!
    @IBOutlet weak var btnDone: UIBarButtonItem!
    @IBOutlet weak var lastImage: UIImageView!
    
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
        
        
        if let alb = currentAlbum{
            btnDone.isEnabled = true
            txtFieldName.text = alb.setedName
            datePicker.date = alb.setedDate
            
            if let photoCard = albumPhoto{
                myImages.append(photoCard.setedImage)
            }
        }
    }
    
    @IBAction func photoSelector(_ sender: UIButton) {
        imgPicker = ImagePicker()
        imgPicker.pickImage(self){ (image) in
            self.lastImage.image = image
            self.myImages.append(image)
            self.photosCountlbl.text = "\(self.myImages.count)"
        }
    }
    
    @IBAction func btnCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func btnDone(_ sender: Any) {
        if let album = currentAlbum{
//            let albumStatus:ModelStatus = ModelManager.shared().editAlbum(target: album, newName: txtFieldName.text, newDate: datePicker.date as NSDate)
//            if(!albumStatus.successful){
//                fatalError(albumStatus.description)
//            }
        }
            
        else{
            
            let album = Album(name: txtFieldName.text!, date: datePicker.date)
            cloudKitControler.shared.save(record: album.record, on: .privateDB) { (result) in
                switch result {
                case .success(_):
                    for image in self.myImages {  
                        let id = UUID.init().uuidString
                        let photo = Photo(fullImage: image, compression: 0.5, albumID: album.recordID, id: id)
                        self.cloudKitControler.shared.save(record: photo.record, on: .privateDB) { (result) in
                            switch result {
                            case .success(let photo):
                                print(photo)
                            case .failure(let error):
                                print(error)
                            }
                        }
                    }
                case .failure(let error):
                    print(error)
                }
                //            let albumStatus:ModelStatus = ModelManager.shared().addAlbum(name: txtFieldName.text!, date: datePicker!.date as NSDate)
                //            if (!albumStatus.successful){
                //                fatalError(albumStatus.description)
                //            }
                //                for img in self.myImages{
                //                let photoStatus:ModelStatus = ModelManager.shared().addPhoto(target: albumStatus.albumIdentifier!, photo: img)
                //                if (!photoStatus.successful){
                //                    fatalError(albumStatus.description)
                //                }
                //            }
                
                //            NotificationHandler.notify(title: "Um album para ser revisto", body: "Você não visita o album \(album.name)", date: album.date, sound: true, badges: false)
            }  
        }
        self.dismiss(animated: true, completion: nil)
        
    }
    //    }
}
