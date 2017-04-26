//
//  GameViewController.swift
//  DouYuZhiBo
//
//  Created by 买明 on 26/04/2017.
//  Copyright © 2017 买明. All rights reserved.
//

import UIKit

class GameViewController: BaseViewController {

    lazy var gameVM = GameViewModel()
    lazy var collectionView: UICollectionView = { [weak self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: GAME_COLLECTION_ITEM_WIDTH,
                                 height: GAME_COLLECTION_ITEM_HEIGHT)
        layout.minimumLineSpacing = 0.0
        layout.minimumInteritemSpacing = 0.0
        layout.sectionInset = UIEdgeInsets(top: 0.0,
                                           left: GAME_COLLECTION_MARGIN,
                                           bottom: 0.0,
                                           right: GAME_COLLECTION_MARGIN)
        layout.headerReferenceSize = CGSize(width: SCREEN_WIDTH, height: GAME_COLLECTION_HEADER_HEIGHT)
        let view = UICollectionView(frame: self!.view.bounds,
                                    collectionViewLayout: layout)
        view.dataSource = self
        
        view.backgroundColor = .white
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        view.register(UINib(nibName: String(describing: GameCollectionCell.self),
                                      bundle: nil),
                      forCellWithReuseIdentifier: GAME_COLLECTION_IDENTIFIER)
        view.register(UINib(nibName: String(describing: HeaderCollectionView.self),
                            bundle: nil),
                      forSupplementaryViewOfKind: UICollectionElementKindSectionHeader,
                      withReuseIdentifier: GAME_COLLECTION_HEADER_IDENTIFIER)
        
        return view
    }()
    lazy var topHeaderView: HeaderCollectionView = {
        let view = HeaderCollectionView.create()
        
        view.frame = CGRect(x: 0.0,
                            y: -(GAME_COLLECTION_HEADER_HEIGHT + GAME_GAME_VIEW_HEIGHT),
                            width: SCREEN_WIDTH,
                            height: GAME_COLLECTION_HEADER_HEIGHT)
        
        view.iconImageView.image = UIImage(named: "Img_orange_3x14_")
        view.titleLabel.text = "常用"
        view.moreButton.isHidden = true
        return view
    }()
    lazy var gameView: RecommandGameView = {
        let view = RecommandGameView.create()
        
        view.frame = CGRect(x: 0.0,
                            y: -GAME_GAME_VIEW_HEIGHT,
                            width: SCREEN_WIDTH,
                            height: GAME_GAME_VIEW_HEIGHT)
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        loadData()
    }

}

extension GameViewController {
    override func setupUI() {
        contentView = collectionView
        
        collectionView.addSubview(topHeaderView)
        collectionView.addSubview(gameView)
        collectionView.contentInset = UIEdgeInsets(top: GAME_COLLECTION_HEADER_HEIGHT + GAME_GAME_VIEW_HEIGHT,
                                                   left: 0.0,
                                                   bottom: 0.0,
                                                   right: 0.0)
        
        view.addSubview(collectionView)
        
        super.setupUI()
    }
    
    func loadData() {
        gameVM.loadGameData {
            self.collectionView.reloadData()
            self.gameView.games = Array(self.gameVM.games[0..<10])
            
            self.didLoadData()
        }
    }
}

extension GameViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameVM.games.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GAME_COLLECTION_IDENTIFIER, for: indexPath) as! GameCollectionCell
        
        cell.baseGame = gameVM.games[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader,
                                                                         withReuseIdentifier: GAME_COLLECTION_HEADER_IDENTIFIER,
                                                                         for: indexPath) as! HeaderCollectionView
        headerView.titleLabel.text = "全部"
        headerView.iconImageView.image = UIImage(named: "Img_orange_3x14_")
        headerView.moreButton.isHidden = true
        
        return headerView
    }
}
