//
//  BaseViewModel.swift
//  DouYuZhiBo
//
//  Created by 买明 on 26/04/2017.
//  Copyright © 2017 买明. All rights reserved.
//

import Foundation

class BaseViewModel {
    lazy var anchorGroups = [AnchorGroup]()
}

extension BaseViewModel {
    func loadAnchorData(_ isGroup: Bool, _ urlString: String, _ parameters: [String: Any]? = nil, completion: @escaping () -> ()) {
        NetworkTools.request(.get, urlString, parameters) { [weak self] (result) in
            guard let resultDict = result as? [String: Any] else { return }
            guard let dataArray = resultDict["data"] as? [[String: Any]] else { return }
            
            if isGroup {
                for dict in dataArray {
                    self?.anchorGroups.append(AnchorGroup(dict))
                }
            } else {
                let group = AnchorGroup()
                for dict in dataArray {
                    group.anchors.append(AnchorModel(dict))
                }
                
                self?.anchorGroups.append(group)
            }
            
            completion()
        }
    }
}
