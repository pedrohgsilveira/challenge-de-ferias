//
//  Photo+CoreDataProperties.swift
//  Challenge de ferias 2.0
//
//  Created by Pedro Henrique Guedes Silveira on 13/07/19.
//  Copyright © 2019 Pedro Henrique Guedes Silveira. All rights reserved.
//
//

import Foundation
import CoreData


extension Photo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Photo> {
        return NSFetchRequest<Photo>(entityName: "Photo")
    }

    @NSManaged public var photoPath: String?

}
