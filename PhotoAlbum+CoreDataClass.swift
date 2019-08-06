//
//  PhotoAlbum+CoreDataClass.swift
//  Challenge de ferias 2.0
//
//  Created by Pedro Henrique Guedes Silveira on 15/07/19.
//  Copyright © 2019 Pedro Henrique Guedes Silveira. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit


public class PhotoAlbum: NSManagedObject {
    
    
    private let dF = DateFormatter()
    
    func feed(name:String, date:NSDate){
    
        dF.dateFormat = "dd-MM-yyyy hh:mm:ssZ"
    
        self.name = name
        self.date = date
        
    }
    
    
    func modifyData(newName: String?, NewDate:NSDate?) -> Bool{
    
        var existModification:Bool = false
        dF.dateFormat = "dd-MM-yyyy hh:mm:ssZ"
    
    
        if let newName = newName{
            if newName != name{
                name = newName
                existModification = true
            }
        }
    
        if let newDate = NewDate{
            if NewDate != date{
                date = newDate
                existModification = true
            }
        }
    
        return existModification
    }
    
}
