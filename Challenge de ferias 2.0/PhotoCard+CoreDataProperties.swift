//
//  PhotoCard+CoreDataProperties.swift
//  Challenge de ferias 2.0
//
//  Created by Pedro Henrique Guedes Silveira on 13/07/19.
//  Copyright © 2019 Pedro Henrique Guedes Silveira. All rights reserved.
//
//

import Foundation
import CoreData


extension PhotoCard {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PhotoCard> {
        return NSFetchRequest<PhotoCard>(entityName: "PhotoCard")
    }

    @NSManaged public var name: String?
    @NSManaged public var photoPin: Bool
    @NSManaged public var date: NSDate?
    @NSManaged public var album: PhotoAlbum?

}
