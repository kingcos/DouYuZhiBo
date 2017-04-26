//
//  RecommandViewModel.swift
//  DouYuZhiBo
//
//  Created by 买明 on 24/04/2017.
//  Copyright © 2017 买明. All rights reserved.
//

import Foundation

class RecommandViewModel: BaseViewModel {
    lazy var bigDataRoomGroup = AnchorGroup()
    lazy var yanzhiRoomGroup = AnchorGroup()
    
    lazy var recycleModels = [RecycleModel]()
}

extension RecommandViewModel {
    
    func requestRecommandData(_ completion: @escaping () -> ()) {
        let parameters = ["limit": "4",
                          "offset": "0",
                          "time": Date.getCurrentMillisecond()]
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        NetworkTools.request(.get,
                             "http://capi.douyucdn.cn/api/v1/getbigDataRoom",
                             ["time": Date.getCurrentMillisecond()]) { [weak self] (result) in
                                guard let resultDict = result as? [String: Any] else { return }
                                guard let dataArray = resultDict["data"] as? [[String: Any]] else { return }
                                
                                self?.bigDataRoomGroup.tag_name = "最热"
                                self?.bigDataRoomGroup.icon_name = "home_header_hot_18x18_"
                                
                                for dict in dataArray {
                                    let anchor = AnchorModel(dict)
                                    self?.bigDataRoomGroup.anchors.append(anchor)
                                }
                                
                                dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        NetworkTools.request(.get,
                             "http://capi.douyucdn.cn/api/v1/getVerticalRoom",
                             parameters) { [weak self] (result) in
                                guard let resultDict = result as? [String: Any] else { return }
                                guard let dataArray = resultDict["data"] as? [[String: Any]] else { return }
                                
                                self?.yanzhiRoomGroup.tag_name = "颜值"
                                self?.yanzhiRoomGroup.icon_name = "columnYanzhiIcon_20x20_"
                                
                                for dict in dataArray {
                                    let anchor = AnchorModel(dict)
                                    self?.yanzhiRoomGroup.anchors.append(anchor)
                                }
                                
                                dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        loadAnchorData(true, "http://capi.douyucdn.cn/api/v1/getHotCate", parameters) {
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: DispatchQueue.main) { [weak self] in
            guard let myself = self else { return }
            
            myself.anchorGroups.insert(myself.yanzhiRoomGroup, at: 0)
            myself.anchorGroups.insert(myself.bigDataRoomGroup, at: 0)
            
            completion()
        }
        
    }
    
    func requestRecycleData(_ completion: @escaping () -> ()) {
        NetworkTools.request(.get,
                             "http://www.douyutv.com/api/v1/slide/6",
                             ["version": "2.300"]) { [weak self] (result) in
                                guard let resultDict = result as? [String: Any] else { return }
                                guard let dataArray = resultDict["data"] as? [[String: Any]] else { return }
                                
                                for dict in dataArray {
                                    self?.recycleModels.append(RecycleModel(dict))
                                }
                                
                                completion()
        }
    }
}
