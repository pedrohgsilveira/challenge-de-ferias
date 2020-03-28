//
//  Extensions.swift
//  Challenge de ferias 2.0
//
//  Created by Pedro Henrique Guedes Silveira on 25/03/20.
//  Copyright © 2020 Pedro Henrique Guedes Silveira. All rights reserved.
//

import Foundation
import CloudKit
import UIKit

extension CKAsset {
    convenience init(image: UIImage, compression: CGFloat) {
        let fileURL = ImagesControl.saveToDisk(image: image, compression: compression)
        self.init(fileURL: fileURL)
    }
    
    var image: UIImage? {
        guard let data = try? Data(contentsOf: fileURL!), let image = UIImage(data: data) else {
            return nil
        }
        
        return image
    }
}

