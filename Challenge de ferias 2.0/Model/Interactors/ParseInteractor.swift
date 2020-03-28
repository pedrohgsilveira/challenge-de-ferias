//
//  ParseInteractor.swift
//  Challenge de ferias 2.0
//
//  Created by Pedro Henrique Guedes Silveira on 27/03/20.
//  Copyright © 2020 Pedro Henrique Guedes Silveira. All rights reserved.
//

import Foundation
import CloudKit
import UIKit

final class ParseInteractor {
    
    public func parse(records: [CKRecord], into model: RecordType) -> [EntityObject]? {
        switch model {
        case .photo:
            var photos = [Photo]()
            for record in records {
                let id = record.recordID.recordName
                let asset = record["image"] as? CKAsset
                let albumReference = record["album"] as? CKRecord.Reference
                let albumID = albumReference?.recordID
                let photo = Photo(fullImage: (asset?.image) ?? UIImage(), compression: 0.5, albumID: albumID! , id: id)

                photos.append(photo)
            }
            return photos
        case .album:
            var albums = [Album]()
            for record in records {
                let id = record.recordID.recordName
                let album = Album(name: record["name"] ?? "", date: record["date"]!)
                albums.append(album)
            }
            return albums
       
        }
    }
}
