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
    private var id = UUID()
    
    func feed(name:String, photo:UIImage?, date: NSDate) {
    
        dF.dateFormat = "dd-MM-yyyy hh:mm:ssZ"
        
        self.name = name
        self.date = date
    
        
        if let photo = photo{
            let photoPath = dF.string(from: Date())
            ImagesControl.saveImage(image: photo, nameWithoutExtension: photoPath)
            self.photoPath = photoPath
        }
    }
    
    func modifyData(newName:String?, newDate: NSDate?) -> Bool{
    
        var existModification:Bool = false
    
        if let newName = newName{
            if newName != name{
                name = newName
                existModification = true
            }
        }
    
        if let newDate = newDate{
            if newDate != date{
                date = newDate
                existModification = true
            }
        }
    
        return existModification
    
    }

}
