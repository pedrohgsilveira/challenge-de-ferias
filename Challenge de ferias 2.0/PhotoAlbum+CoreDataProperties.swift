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
    @NSManaged public var completePhoto: NSOrderedSet?

}

// MARK: Generated accessors for completePhoto
extension PhotoAlbum {

    @objc(insertObject:inCompletePhotoAtIndex:)
    @NSManaged public func insertIntoCompletePhoto(_ value: PhotoCard, at idx: Int)

    @objc(removeObjectFromCompletePhotoAtIndex:)
    @NSManaged public func removeFromCompletePhoto(at idx: Int)

    @objc(insertCompletePhoto:atIndexes:)
    @NSManaged public func insertIntoCompletePhoto(_ values: [PhotoCard], at indexes: NSIndexSet)

    @objc(removeCompletePhotoAtIndexes:)
    @NSManaged public func removeFromCompletePhoto(at indexes: NSIndexSet)

    @objc(replaceObjectInCompletePhotoAtIndex:withObject:)
    @NSManaged public func replaceCompletePhoto(at idx: Int, with value: PhotoCard)

    @objc(replaceCompletePhotoAtIndexes:withCompletePhoto:)
    @NSManaged public func replaceCompletePhoto(at indexes: NSIndexSet, with values: [PhotoCard])

    @objc(addCompletePhotoObject:)
    @NSManaged public func addToCompletePhoto(_ value: PhotoCard)

    @objc(removeCompletePhotoObject:)
    @NSManaged public func removeFromCompletePhoto(_ value: PhotoCard)

    @objc(addCompletePhoto:)
    @NSManaged public func addToCompletePhoto(_ values: NSOrderedSet)

    @objc(removeCompletePhoto:)
    @NSManaged public func removeFromCompletePhoto(_ values: NSOrderedSet)

}
