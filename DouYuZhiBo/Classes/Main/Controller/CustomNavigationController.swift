//
//  CustomNavigationController.swift
//  DouYuZhiBo
//
//  Created by 买明 on 26/04/2017.
//  Copyright © 2017 买明. All rights reserved.
//

import UIKit

class CustomNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let systemGes = interactivePopGestureRecognizer else { return }
        guard let gesView = systemGes.view else { return }
        
        /*
        var count: UInt32 = 0
        let ivars = class_copyIvarList(UIGestureRecognizer.self, &count)!
        for i in 0..<count {
            let ivar = ivars[Int(i)]
            let name = ivar_getName(ivar)
            print(String(cString: name!))
        }
        */
        
        let targets = systemGes.value(forKey: "_targets") as? [NSObject]
        guard let targetObject = targets?.first else { return }
        guard let target = targetObject.value(forKey: "target") else { return }

        let action = Selector(("handleNavigationTransition:"))
        
        let panGesture = UIPanGestureRecognizer()
        gesView.addGestureRecognizer(panGesture)
        panGesture.addTarget(target, action: action)
        
        print(targetObject)
        
        
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        viewController.hidesBottomBarWhenPushed = true
        
        super.pushViewController(viewController, animated: animated)
    }

}
