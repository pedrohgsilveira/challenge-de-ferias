//
//  AlbumIteractor.swift
//  Challenge de ferias 2.0
//
//  Created by Pedro Henrique Guedes Silveira on 27/03/20.
//  Copyright © 2020 Pedro Henrique Guedes Silveira. All rights reserved.
//

import Foundation
import CloudKit

final class AlbumIteractor {
    
    private let cloudKitController = CloudKitController.self
    private let parser:ParseInteractor

    
    public static let shared = AlbumIteractor()
    
    private init () {
        self.parser = ParseInteractor()
    }
    
    public func fetch(completionHandler: @escaping (([Album]?) -> Void)) {
        let query = cloudKitController.shared.generateQuery(of: .album, with: NSPredicate(value: true), sortedBy: NSSortDescriptor(key: "creationDate", ascending: false))
        cloudKitController.shared.query(using: query, on: .privateDB) { [weak self] (result) in
            switch result {
            case .success(let records):
                let entityObjects = self?.parser.parse(records: records, into: .album)
                guard let albums = entityObjects as? [Album] else {
                    return
                }
                completionHandler(albums)
            case .failure(let error):
                print(error.localizedDescription)
                completionHandler(nil)
            }
        }
    }
}
