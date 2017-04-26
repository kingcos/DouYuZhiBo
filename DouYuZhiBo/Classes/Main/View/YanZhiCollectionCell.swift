//
//  YanZhiCollectionCell.swift
//  DouYuZhiBo
//
//  Created by 买明 on 24/04/2017.
//  Copyright © 2017 买明. All rights reserved.
//

import UIKit

class YanZhiCollectionCell: BaseCollectionCell {
    
    @IBOutlet weak var cityButton: UIButton!
    
    override var anchor: AnchorModel? {
        didSet {
            super.anchor = anchor
            
            cityButton.setTitle(anchor?.anchor_city, for: .normal)
        }
    }
    
}
