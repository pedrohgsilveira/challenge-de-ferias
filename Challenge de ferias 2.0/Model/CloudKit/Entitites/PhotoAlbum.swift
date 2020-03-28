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
    
    public private (set) var setedName: String
    public private (set) var setedDate: Date
    public private (set) var albumPhotos: [UIImage]
//    var name: String
//    var date: Date
    var imagesFileUrls: [URL?] = []
    
    var recordID: CKRecord.ID
    
    init(name: String, date: Date) {
        
        albumPhotos = []
        self.record = CKRecord(recordType: Album.recordType)
        recordID = record.recordID
        record["name"] = name
        record["date"] = date
        self.setedName = record["name"] as? String ?? "" 
        self.setedDate = record["date"] as? Date ?? Date()
                
        if let assets = record["photos"] as? [CKAsset] {
            for asset in assets {
                imagesFileUrls.append(asset.fileURL)
                if let photo = asset.image {
                    albumPhotos.append(photo)
                }
            }
        }
    }   
}
