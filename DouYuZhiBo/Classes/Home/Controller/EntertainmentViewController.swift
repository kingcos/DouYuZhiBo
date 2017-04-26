//
//  EntertainmentViewController.swift
//  DouYuZhiBo
//
//  Created by 买明 on 26/04/2017.
//  Copyright © 2017 买明. All rights reserved.
//

import UIKit

class EntertainmentViewController: BaseAnchorViewController {
    lazy var entertainmentVM = EntertainmentViewModel()
    
    lazy var menuView: EntertainmentMenuView = {
        let view = EntertainmentMenuView.create()
        view.frame = CGRect(x: 0.0,
                            y: -ENTERTAINMENT_MENU_VIEW_HEIGHT,
                            width: SCREEN_WIDTH,
                            height: ENTERTAINMENT_MENU_VIEW_HEIGHT)
        return view
    }()
}

extension EntertainmentViewController {
    override func setupUI() {
        super.setupUI()
        
        collectionView.addSubview(menuView)
        collectionView.contentInset = UIEdgeInsets(top: ENTERTAINMENT_MENU_VIEW_HEIGHT,
                                                   left: 0.0, bottom: 0.0, right: 0.0)
    }
    
    override func loadData() {
        baseVM = entertainmentVM
        
        entertainmentVM.loadEntertainmentData {
            self.collectionView.reloadData()
            var tempArray = self.entertainmentVM.anchorGroups
            tempArray.removeFirst()
            self.menuView.groups = tempArray
            
            self.didLoadData()
        }
    }
}
