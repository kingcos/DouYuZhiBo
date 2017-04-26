//
//  EntertainmentMenuView.swift
//  DouYuZhiBo
//
//  Created by 买明 on 26/04/2017.
//  Copyright © 2017 买明. All rights reserved.
//

import UIKit

class EntertainmentMenuView: UIView {
    
    var groups: [AnchorGroup]? {
        didSet {
            collectionView.reloadData()
        }
    }

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        autoresizingMask = []
        
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(UINib(nibName: String(describing: EntertainmentMenuCollectionCell.self),
                                      bundle: nil),
                                forCellWithReuseIdentifier: ENTERTAINMENT_MENU_COLLECTION_CELL_IDENTIFIER)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0.0
        layout.minimumInteritemSpacing = 0.0
    }

}

extension EntertainmentMenuView {
    class func create() -> EntertainmentMenuView {
        return Bundle.main.loadNibNamed(String(describing: EntertainmentMenuView.self),
                                        owner: nil,
                                        options: nil)?.first as! EntertainmentMenuView
    }
}

extension EntertainmentMenuView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let groups = groups else { return 0 }
        
        let pageNum = (groups.count - 1) / 8 + 1
        pageControl.numberOfPages = pageNum
        return pageNum
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ENTERTAINMENT_MENU_COLLECTION_CELL_IDENTIFIER, for: indexPath) as! EntertainmentMenuCollectionCell
        
        setupCell(cell, indexPath)
        
        return cell
    }
    
    private func setupCell(_ cell: EntertainmentMenuCollectionCell, _ indexPath: IndexPath) {
        let startIndex = indexPath.row * 8
        var endIndex = (indexPath.row + 1) * 8 - 1
        
        if endIndex > groups!.count - 1 {
            endIndex = groups!.count - 1
        }
        
        cell.groups = Array(groups![startIndex...endIndex])
    }
}

extension EntertainmentMenuView: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x
        pageControl.currentPage = Int(offsetX / scrollView.bounds.width)
    }
}
