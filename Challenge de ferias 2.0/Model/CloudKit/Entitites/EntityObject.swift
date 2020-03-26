//
//  EntityObject.swift
//  Challenge de ferias 2.0
//
//  Created by Pedro Henrique Guedes Silveira on 25/03/20.
//  Copyright © 2020 Pedro Henrique Guedes Silveira. All rights reserved.
//

import CloudKit

public protocol EntityObject: NSObject {
    static var recordType: String { get }
    var record: CKRecord { get }
}
