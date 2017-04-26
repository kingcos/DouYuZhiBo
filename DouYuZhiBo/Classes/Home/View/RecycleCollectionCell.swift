//
//  RecycleCollectionCell.swift
//  DouYuZhiBo
//
//  Created by 买明 on 25/04/2017.
//  Copyright © 2017 买明. All rights reserved.
//

import UIKit
import Kingfisher

class RecycleCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    var recycleModel: RecycleModel? {
        didSet {
            titleLabel.text = recycleModel?.title
            
            guard let url = URL(string: recycleModel?.pic_url ?? "") else { return }
            iconImageView.kf.setImage(with: url,
                                      placeholder: UIImage(named: "Img_default_172x103_"))
        }
    }

}
