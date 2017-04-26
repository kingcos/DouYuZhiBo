//
//  EntertainmentMenuCollectionCell.swift
//  DouYuZhiBo
//
//  Created by 买明 on 26/04/2017.
//  Copyright © 2017 买明. All rights reserved.
//

import UIKit

class EntertainmentMenuCollectionCell: UICollectionViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var groups: [AnchorGroup]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.register(UINib(nibName: String(describing: GameCollectionCell.self),
                                      bundle: nil),
                                forCellWithReuseIdentifier: ENTERTAINMENT_MENU_INNER_CELL_IDENTIFIER)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let itemW = collectionView.bounds.width / 4.0
        let itemH = collectionView.bounds.height / 2.0
        
        layout.itemSize = CGSize(width: itemW, height: itemH)
        layout.minimumLineSpacing = 0.0
        layout.minimumInteritemSpacing = 0.0
    }

}

extension EntertainmentMenuCollectionCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ENTERTAINMENT_MENU_INNER_CELL_IDENTIFIER, for: indexPath) as! GameCollectionCell
        
        cell.clipsToBounds = true
        cell.baseGame = groups![indexPath.row]
        
        return cell
    }
}
