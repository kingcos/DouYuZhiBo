
//
//  BaseCollectionCell.swift
//  DouYuZhiBo
//
//  Created by 买明 on 25/04/2017.
//  Copyright © 2017 买明. All rights reserved.
//

import UIKit
import Kingfisher

class BaseCollectionCell: UICollectionViewCell {
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var onlineButton: UIButton!
    @IBOutlet weak var nicknameLabel: UILabel!
    
    var anchor: AnchorModel? {
        didSet {
            guard let anchor = anchor else { return }
            
            nicknameLabel.text = anchor.nickname
            
            var online = "\(anchor.online)"
            if anchor.online >= 10000 {
                let onlineDouble = Double(anchor.online)
                if onlineDouble / 10000 == floor(onlineDouble / 10000) {
                    online = "\(anchor.online / 10000)万"
                } else {
                    online = String(format: "%.1f万", onlineDouble / 10000)
                }
            }
            
            onlineButton.setTitle(online, for: .normal)
            
            guard let url = URL(string: anchor.vertical_src) else { return }
            mainImageView.kf.setImage(with: url)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    private func setupUI() {
        mainImageView.layer.cornerRadius = 5
        mainImageView.clipsToBounds = true
        
        onlineButton.layer.cornerRadius = 3
        onlineButton.clipsToBounds = true
    }
}
