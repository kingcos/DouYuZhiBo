//
//  FunViewController.swift
//  DouYuZhiBo
//
//  Created by 买明 on 26/04/2017.
//  Copyright © 2017 买明. All rights reserved.
//

import UIKit

class FunViewController: BaseAnchorViewController {
    lazy var funVM = FunViewModel()
}

extension FunViewController {
    override func setupUI() {
        super.setupUI()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.headerReferenceSize = CGSize.zero
        collectionView.contentInset = UIEdgeInsets(top: FUN_CONTROLLER_TOP_MARGIN,
                                                   left: 0.0,
                                                   bottom: 0.0,
                                                   right: 0.0)
    }
}

extension FunViewController {
    override func loadData() {
        baseVM = funVM
        
        funVM.loadFunData {
            self.collectionView.reloadData()
            
            self.didLoadData()
        }
    }
}
