//
//  PhotoIteractor.swift
//  Challenge de ferias 2.0
//
//  Created by Pedro Henrique Guedes Silveira on 27/03/20.
//  Copyright © 2020 Pedro Henrique Guedes Silveira. All rights reserved.
//

import Foundation
import CloudKit

final class PhotoIteractor {
    
    private let cloudKitController = CloudKitController.self
    private let parser:ParseInteractor

    
    public static let shared = PhotoIteractor()
    
    private init () {
        self.parser = ParseInteractor()
    }
    
    public func fetch(completionHandler: @escaping (([Photo]?) -> Void)) {
        let query = cloudKitController.shared.generateQuery(of: .photo, with: NSPredicate(value: true), sortedBy: NSSortDescriptor(key: "creationDate", ascending: false))
        cloudKitController.shared.query(using: query, on: .privateDB) { [weak self] (result) in
            switch result {
            case .success(let records):
                let entityObjects = self?.parser.parse(records: records, into: .photo)
                guard let photos = entityObjects as? [Photo] else {
                    return
                }
                completionHandler(photos)
            case .failure(let error):
                print(error.localizedDescription)
                completionHandler(nil)
            }
        }
    }
}
