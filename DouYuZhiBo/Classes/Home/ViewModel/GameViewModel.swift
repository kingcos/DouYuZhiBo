//
//  GameViewModel.swift
//  DouYuZhiBo
//
//  Created by 买明 on 26/04/2017.
//  Copyright © 2017 买明. All rights reserved.
//

import Foundation

class GameViewModel {
    lazy var games = [GameModel]()
}

extension GameViewModel {
    func loadGameData(_ completion: @escaping () -> ()) {
        NetworkTools.request(.get,
                             "http://capi.douyucdn.cn/api/v1/getColumnDetail",
                             ["shortName": "game"]) { [weak self] (result) in
                                guard let resultDict = result as? [String: Any] else { return }
                                guard let dataArray = resultDict["data"] as? [[String: Any]] else { return }
                                
                                for dict in dataArray {
                                    self?.games.append(GameModel(dict))
                                }
                                
                                completion()

        }
    }
}
