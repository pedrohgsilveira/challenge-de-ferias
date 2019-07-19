//
//  ModelStatus.swift
//  Challenge de ferias 2.0
//
//  Created by Pedro Henrique Guedes Silveira on 13/07/19.
//  Copyright © 2019 Pedro Henrique Guedes Silveira. All rights reserved.
//

import Foundation
import CoreData

public class ModelStatus{
    public private(set) var successful:Bool
    public private(set) var description:String

    init(successful:Bool, description:String) {
        self.successful = successful
        self.description = description
    }

    convenience init(successful:Bool){
        self.init(successful:successful, description:"")
    }

}
