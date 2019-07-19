//
//  AlbumsCollectionViewCell.swift
//  Challenge de ferias 2.0
//
//  Created by Pedro Henrique Guedes Silveira on 16/07/19.
//  Copyright © 2019 Pedro Henrique Guedes Silveira. All rights reserved.
//

import UIKit

class AlbumsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var albumNamelbl: UILabel!
    @IBOutlet var photoCardsColletion: [UIImageView]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
