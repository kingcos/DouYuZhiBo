//
//  UIBarButtonItem+Extension.swift
//  DouYuZhiBo
//
//  Created by 买明 on 23/04/2017.
//  Copyright © 2017 买明. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    convenience init(imageName: String, selectedImageName: String? = nil, size: CGSize? = nil) {
        let button = UIButton()
        button.setImage(UIImage(named: imageName), for: .normal)
        
        if let selectedImageName = selectedImageName {
            button.setImage(UIImage(named: selectedImageName), for: .highlighted)
        }

        if let size = size {
            button.frame = CGRect(origin: CGPoint.zero, size: size)
        } else {
            button.sizeToFit()
        }
        
        self.init(customView: button)
    }
}
