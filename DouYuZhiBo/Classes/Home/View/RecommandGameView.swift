//
//  RecommandGameView.swift
//  DouYuZhiBo
//
//  Created by 买明 on 25/04/2017.
//  Copyright © 2017 买明. All rights reserved.
//

import UIKit

class RecommandGameView: UIView {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var games: [BaseGameModel]? {
        didSet {            
            collectionView.reloadData()
        }
    }

    override func awakeFromNib() {
        autoresizingMask = []
        
//        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(UINib(nibName: String(describing: GameCollectionCell.self),
                                      bundle: nil),
                                forCellWithReuseIdentifier: RECOMMAND_GAME_VIEW_IDENTIFIER)
        collectionView.contentInset = UIEdgeInsets(top: 0.0,
                                                   left: RECOMMAND_GAME_VIEW_INSET_LR,
                                                   bottom: 0.0,
                                                   right: RECOMMAND_GAME_VIEW_INSET_LR)
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        
//        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
//        layout.itemSize = CGSize(width: 80.0, height: 90.0)
//        layout.minimumLineSpacing = 0
//        layout.minimumInteritemSpacing = 0
//        layout.scrollDirection = .horizontal
//    }

}

extension RecommandGameView {
    class func create() -> RecommandGameView {
        return Bundle.main.loadNibNamed(String(describing: RecommandGameView.self),
                                        owner: nil,
                                        options: nil)?.first as! RecommandGameView
    }
}

extension RecommandGameView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return games?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RECOMMAND_GAME_VIEW_IDENTIFIER, for: indexPath) as! GameCollectionCell
        
        cell.baseGame = games?[indexPath.row]
        
        return cell
    }
}
