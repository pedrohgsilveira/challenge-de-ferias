//
//  PhotoAlbum+CoreDataProperties.swift
//  Challenge de ferias 2.0
//
//  Created by Pedro Henrique Guedes Silveira on 13/07/19.
//  Copyright © 2019 Pedro Henrique Guedes Silveira. All rights reserved.
//
//

import Foundation
import CoreData


extension PhotoAlbum {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PhotoAlbum> {
        return NSFetchRequest<PhotoAlbum>(entityName: "PhotoAlbum")
    }

    @NSManaged public var name: String?
    @NSManaged public var date: NSDate?
    @NSManaged public var secret: Bool
    @NSManaged public var completePhoto: NSSet?

}

// MARK: Generated accessors for completePhoto
extension PhotoAlbum {

    @objc(addCompletePhotoObject:)
    @NSManaged public func addToCompletePhoto(_ value: PhotoCard)

    @objc(removeCompletePhotoObject:)
    @NSManaged public func removeFromCompletePhoto(_ value: PhotoCard)

    @objc(addCompletePhoto:)
    @NSManaged public func addToCompletePhoto(_ values: NSSet)

    @objc(removeCompletePhoto:)
    @NSManaged public func removeFromCompletePhoto(_ values: NSSet)

}
