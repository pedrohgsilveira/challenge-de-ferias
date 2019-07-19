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
        
        if let alb = currentAlbum{
            btnDone.isEnabled = true
            txtFieldName.text = alb.name
            
            if let way = alb.completePhoto{
                for i in 0...way.count - 1 {
                    print(way.count)
                    guard let path = way[i] as? PhotoCard else {return}
                    if let myPath = path.photoPath{
                        let answer:String? = ImagesControl.getFile(filePathWithoutExtension: myPath)
                        if let answer = answer, let images = UIImage(contentsOfFile: answer){
                            myImages.append(images)
                        }
                    }
                }
            }
        }
    }
    
    
    
    
    
    @IBAction func photoSelector(_ sender: UIButton) {
            imgPicker = ImagePicker()
        
            imgPicker.pickImage(self) { (image) in
                self.myImages.append(image)
                self.imgChanged = true
                self.lastImage.image = self.myImages[self.myImages.count - 1]
                self.photosCountlbl.text = "\(self.myImages.count)"
            }
    }

    @IBAction func btnCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }


    @IBAction func btnDone(_ sender: Any) {

        var newPhoto:UIImage? = nil
        if(imgChanged){
            newPhoto = lastImage.image
            guard let currentAlbum = currentAlbum else {return}
            guard let newPhoto = newPhoto else {return}
        }
        
        var teste:Bool = false


        if let album = currentAlbum{
            let albumStatus:ModelStatus = ModelManager.shared().editAlbum(target: album, newName: txtFieldName.text, newDate: datePicker.date as NSDate)
            print(teste)
            if(!albumStatus.successful){
                fatalError(albumStatus.description)
            }

        }
        else{
            print(teste)
            if let txt = txtFieldName.text{
                if myImages.count > 0{
                    for i in 0...myImages.count - 1{
                        teste = true
                        let photoStatus:ModelStatus = ModelManager.shared().addPhoto(target: currentAlbum!, photo: myImages[i], name: "Mudar", date: nil)
                        if(!photoStatus.successful){
                            fatalError(photoStatus.description)
                        }
                    }
                    print(teste)
                }
                print(teste)
                let albumStatus:ModelStatus = ModelManager.shared().addAlbum(name: txt, date: datePicker.date as NSDate)
                if(!albumStatus.successful){
                    fatalError(albumStatus.description)
                }
            }
            print(teste)
        }
        self.dismiss(animated: true, completion: nil)

    }
}
