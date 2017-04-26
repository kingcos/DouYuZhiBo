//
//  HeaderCollectionView.swift
//  DouYuZhiBo
//
//  Created by 买明 on 23/04/2017.
//  Copyright © 2017 买明. All rights reserved.
//

import UIKit

class HeaderCollectionView: UICollectionReusableView {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var moreButton: UIButton!
    
    var group: AnchorGroup? {
        didSet {
            titleLabel.text = group?.tag_name
            iconImageView.image = UIImage(named: group?.icon_name ?? "home_header_normal_18x18_")
        }
    }
}

extension HeaderCollectionView {
    class func create() -> HeaderCollectionView {
        return Bundle.main.loadNibNamed(String(describing: HeaderCollectionView.self),
                                        owner: nil,
                                        options: nil)?.first as! HeaderCollectionView
    }
}
