//
//  MainTabBarController.swift
//  DouYuZhiBo
//
//  Created by 买明 on 22/04/2017.
//  Copyright © 2017 买明. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addChildVC("Home")
        addChildVC("Live")
        addChildVC("Follow")
        addChildVC("Profile")
    }
    
    private func addChildVC(_ name: String) {
        guard let childVC = UIStoryboard(name: name, bundle: nil).instantiateInitialViewController() else { return }
        addChildViewController(childVC)
    }

}
