//
//  PhotoAlbum.swift
//  Challenge de ferias 2.0
//
//  Created by Pedro Henrique Guedes Silveira on 25/03/20.
//  Copyright © 2020 Pedro Henrique Guedes Silveira. All rights reserved.
//

import Foundation
import UIKit
import CloudKit

class Album: NSObject, EntityObject {
  
    
    var record: CKRecord
    
    static let recordType = "Album"
    
    var name: String
    var date: Date
    var imagesFileUrls: [URL?] = []
    
    var recordID: CKRecord.ID
    
    override init() {
        self.record = CKRecord(recordType: Album.recordType)
        recordID = record.recordID
        name = record["name"] as? String ?? "" 
        date = record["date"] as? Date ?? Date()
                
        if let photos = record["photos"] as? [CKAsset] {
            for photo in photos {
                imagesFileUrls.append(photo.fileURL)
            }
        }
    }   
}
