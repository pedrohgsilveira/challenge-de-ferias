//
//  MyNotifications.swift
//  Challenge de ferias 2.0
//
//  Created by Pedro Henrique Guedes Silveira on 28/07/19.
//  Copyright © 2019 Pedro Henrique Guedes Silveira. All rights reserved.
//

import Foundation
import UIKit


class MyNotification{
    var identifier:String
    var actions:[(title:String, action:() -> Void, appReOpens:Bool)]?
    
    
    init(identifier:String, actions:[(title:String, action:() -> Void, appReOpens:Bool)]?) {
        self.identifier = identifier
        self.actions = actions
    }
    
    
    
    
}
