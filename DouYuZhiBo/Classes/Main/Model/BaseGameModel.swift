//
//  BaseGameModel.swift
//  DouYuZhiBo
//
//  Created by 买明 on 26/04/2017.
//  Copyright © 2017 买明. All rights reserved.
//

import UIKit

class BaseGameModel: NSObject {
    var tag_name = ""
    var icon_url = ""
    
    override init() {
        super.init()
    }
    
    init(_ dict: [String: Any]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
