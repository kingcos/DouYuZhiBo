//
//  FunViewModel.swift
//  DouYuZhiBo
//
//  Created by 买明 on 26/04/2017.
//  Copyright © 2017 买明. All rights reserved.
//

import Foundation

class FunViewModel: BaseViewModel {
    
}

extension FunViewModel {
    func loadFunData(_ completion: @escaping () -> ()) {
        let parameters = ["limit": 30, "offset": 0]
        loadAnchorData(false,
                       "http://capi.douyucdn.cn/api/v1/getColumnRoom/3",
                       parameters, completion: completion)
    }
}
