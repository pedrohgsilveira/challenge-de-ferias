//
//  Photo.swift
//  Challenge de ferias 2.0
//
//  Created by Pedro Henrique Guedes Silveira on 25/03/20.
//  Copyright © 2020 Pedro Henrique Guedes Silveira. All rights reserved.
//

import Foundation
import CloudKit
import UIKit

class Photo: NSObject, EntityObject {
    
    let record: CKRecord
    static let recordType = "Photo"
    
    public private (set) var setedImage: UIImage 
//    var fullImage: UIImage
//    var compression: CGFloat
//    var albumID: CKRecord.ID
//    var id: String
    
    
    init(fullImage: UIImage, compression: CGFloat, albumID: CKRecord.ID, id: String) {
        
        setedImage = UIImage()
        
        record = CKRecord(recordType: Photo.recordType)
        record["album"] = CKRecord.Reference(recordID: albumID, action: .deleteSelf)
        record["image"] = CKAsset(image: fullImage, compression: compression)
        
        let recordAsset = record["image"] as? CKAsset
        
        if let image = recordAsset?.image {
            setedImage = image
        }
        
    }

}


