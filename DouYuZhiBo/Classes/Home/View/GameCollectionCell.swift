//
//  GameCollectionCell.swift
//  DouYuZhiBo
//
//  Created by 买明 on 25/04/2017.
//  Copyright © 2017 买明. All rights reserved.
//

import UIKit
import Kingfisher

class GameCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var tagLabel: UILabel!
    
    var baseGame: BaseGameModel? {
        didSet {
            tagLabel.text = baseGame?.tag_name ?? "更多"
            
            iconImageView.kf.setImage(with: URL(string: baseGame?.icon_url ?? ""),
                                      placeholder: UIImage(named: "btn_v_more_34x34_"))
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        iconImageView.layer.cornerRadius = iconImageView.bounds.width * 0.5
        iconImageView.layer.masksToBounds = true
    }

}
