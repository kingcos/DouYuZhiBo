//
//  RecycleModel.swift
//  DouYuZhiBo
//
//  Created by 买明 on 25/04/2017.
//  Copyright © 2017 买明. All rights reserved.
//

import UIKit

class RecycleModel: NSObject {

    var title = ""
    var pic_url = ""
    
    var anchor: AnchorModel?
    var room: [String: Any]? {
        didSet {
            guard let room = room else { return }
            anchor = AnchorModel(room)
        }
    }
    
    init(_ dict: [String: Any]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    

}
