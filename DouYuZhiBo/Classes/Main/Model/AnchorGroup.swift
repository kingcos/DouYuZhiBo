//
//  AnchorGroup.swift
//  DouYuZhiBo
//
//  Created by 买明 on 24/04/2017.
//  Copyright © 2017 买明. All rights reserved.
//

import UIKit

class AnchorGroup: BaseGameModel {
    lazy var anchors = [AnchorModel]()
    
    var room_list : [[String: Any]]? {
        didSet {
            guard let room_list = room_list else { return }
            for dict in room_list {
                anchors.append(AnchorModel(dict))
            }
        }
    }
    
    var icon_name = "home_header_normal_18x18_"
}
