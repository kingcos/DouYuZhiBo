//
//  EntertainmentViewModel.swift
//  DouYuZhiBo
//
//  Created by 买明 on 26/04/2017.
//  Copyright © 2017 买明. All rights reserved.
//

import Foundation

class EntertainmentViewModel: BaseViewModel {
    
}

extension EntertainmentViewModel {
    func loadEntertainmentData(_ completion: @escaping () -> ()) {
        loadAnchorData(true, "http://capi.douyucdn.cn/api/v1/getHotRoom/2", completion: completion)
    }
}
