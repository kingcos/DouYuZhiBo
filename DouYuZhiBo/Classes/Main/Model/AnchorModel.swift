//
//  AnchorModel.swift
//  DouYuZhiBo
//
//  Created by 买明 on 24/04/2017.
//  Copyright © 2017 买明. All rights reserved.
//

import UIKit

class AnchorModel: NSObject {
    var room_id = 0
    var vertical_src = ""
    var isVertical = 0
    var room_name = ""
    var nickname = ""
    var online = 0
    var anchor_city = ""
    
    init(_ dict: [String: Any]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
