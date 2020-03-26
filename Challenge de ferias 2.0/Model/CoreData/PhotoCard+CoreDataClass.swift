//
//  PhotoCard+CoreDataClass.swift
//  Challenge de ferias 2.0
//
//  Created by Pedro Henrique Guedes Silveira on 15/07/19.
//  Copyright © 2019 Pedro Henrique Guedes Silveira. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit


public class PhotoCard: NSManagedObject {
    
    private let dF = DateFormatter()    
    func feed(photo:UIImage?) {
    

        
        if let photo = photo{
            let photoPath = "\(photo.hash) \(photo.hashValue)"
            ImagesControl.saveImage(image: photo, nameWithoutExtension: photoPath)
            print("Nome: \(photoPath)")
            self.photoPath = photoPath
        }
    }
    
    
//    func modifyData(newName:String?, newDate: NSDate?) -> Bool{
//
//        var existModification:Bool = false
//
//        if let newName = newName{
//            if newName != name{
//                name = newName
//                existModification = true
//            }
//        }
//
//        if let newDate = newDate{
//            if newDate != date{
//                date = newDate
//                existModification = true
//            }
//        }
//
//        return existModification
//
//    }

}
