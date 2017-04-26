//
//  BaseViewController.swift
//  DouYuZhiBo
//
//  Created by 买明 on 26/04/2017.
//  Copyright © 2017 买明. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    var contentView: UIView?

    fileprivate lazy var animImageView: UIImageView = { [weak self] in
        let imageView = UIImageView(image: UIImage(named: "yubaSDK_loading_shark1"))
        imageView.center = self!.view.center
        imageView.animationImages = [UIImage(named: "yubaSDK_loading_shark1")!, UIImage(named: "yubaSDK_loading_shark2")!]
        imageView.animationDuration = 0.5
        imageView.animationRepeatCount = LONG_MAX
        imageView.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin]
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

extension BaseViewController {
    func setupUI() {
        contentView?.isHidden = true
        
        view.addSubview(animImageView)
        
        animImageView.startAnimating()
        
        view.backgroundColor = .white
    }
    
    func didLoadData() {
        animImageView.stopAnimating()
        animImageView.isHidden = true
        contentView?.isHidden = false
    }
}
