//
//  AppDelegate.swift
//  DouYuZhiBo
//
//  Created by 买明 on 22/04/2017.
//  Copyright © 2017 买明. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        UITabBar.appearance().tintColor = .orange
        UINavigationBar.appearance().barTintColor = .orange
        
        return true
    }
    
}

