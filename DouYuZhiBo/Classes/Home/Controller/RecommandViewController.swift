
//
//  RecommandViewController.swift
//  DouYuZhiBo
//
//  Created by 买明 on 23/04/2017.
//  Copyright © 2017 买明. All rights reserved.
//

import UIKit

class RecommandViewController: BaseAnchorViewController {
    
    lazy var recommandVM = RecommandViewModel()
    
    lazy var recommandRecycleView: RecommandRecycleView = {
        let view = RecommandRecycleView.create()
        view.frame = CGRect(x: 0.0,
                            y: -(RECOMMAND_RECYCLE_VIEW_HEIGHT + RECOMMAND_GAME_VIEW_HEIGHT),
                            width: SCREEN_WIDTH,
                            height: RECOMMAND_RECYCLE_VIEW_HEIGHT)
        return view
    }()
    lazy var recommandGameView: RecommandGameView = {
        let view = RecommandGameView.create()
        view.frame = CGRect(x: 0.0,
                            y: -RECOMMAND_GAME_VIEW_HEIGHT,
                            width: SCREEN_WIDTH,
                            height: RECOMMAND_GAME_VIEW_HEIGHT)
        return view
    }()

}

extension RecommandViewController {
    override func setupUI() {
        super.setupUI()
        
        collectionView.addSubview(recommandRecycleView)
        collectionView.addSubview(recommandGameView)
        
        collectionView.contentInset = UIEdgeInsets(top: RECOMMAND_RECYCLE_VIEW_HEIGHT + RECOMMAND_GAME_VIEW_HEIGHT,
                                                   left: 0.0, bottom: 0.0, right: 0.0)
    }
    
    override func loadData() {
        baseVM = recommandVM
        
        // 闭包对控制器有强引用，控制器对对象有强引用，但对象对闭包没有强引用
        recommandVM.requestRecommandData {// [weak self] in
            self.collectionView.reloadData()
            
            var groups = self.recommandVM.anchorGroups
            groups.removeFirst()
            groups.removeFirst()
            
            let moreGroup = AnchorGroup()
            moreGroup.tag_name = "更多"
            groups.append(moreGroup)
            
            self.recommandGameView.games = groups
            
            self.didLoadData()
        }
        
        recommandVM.requestRecycleData {
            self.recommandRecycleView.recycleModels = self.recommandVM.recycleModels
        }
    }
}

extension RecommandViewController: UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RECOMMAND_YANZHI_CELL_IDENTIFIER, for: indexPath) as! YanZhiCollectionCell
            cell.anchor = recommandVM.anchorGroups[indexPath.section].anchors[indexPath.row]
            return cell
        } else {
            return super.collectionView(collectionView, cellForItemAt: indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: RECOMMAND_CELL_WIDTH, height: RECOMMAND_YANZHI_CELL_HEIGHT)
        }
        
        return CGSize(width: RECOMMAND_CELL_WIDTH, height: RECOMMAND_NORMAL_CELL_HEIGHT)
    }
    
}
