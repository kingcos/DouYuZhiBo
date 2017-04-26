//
//  NormalCollectionCell.swift
//  DouYuZhiBo
//
//  Created by 买明 on 24/04/2017.
//  Copyright © 2017 买明. All rights reserved.
//

import UIKit

class NormalCollectionCell: BaseCollectionCell {
    
    @IBOutlet weak var roomNameLabel: UILabel!
    
    override var anchor: AnchorModel? {
        didSet {
            super.anchor = anchor
            
            roomNameLabel.text = anchor?.room_name
        }
    }
}
