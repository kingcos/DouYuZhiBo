//
//  PageContentView.swift
//  DouYuZhiBo
//
//  Created by 买明 on 23/04/2017.
//  Copyright © 2017 买明. All rights reserved.
//

import UIKit

protocol PageContentViewDelegate: class {
    func pageContentView(_ view: PageContentView, with progress: CGFloat, from sourceIndex: Int, to targetIndex: Int)
}

class PageContentView: UIView {

    var childVCs: [UIViewController]
    var initialOffsetX: CGFloat = 0.0
    var isDisableScrollViewDelegate = false
    weak var parentVC: UIViewController?
    weak var delegate: PageContentViewDelegate?
    
    lazy var collectionView: UICollectionView = { [weak self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self!.bounds.size
        layout.minimumLineSpacing = 0.0
        layout.minimumInteritemSpacing = 0.0
        layout.scrollDirection = .horizontal
        
        let view = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        view.bounces = false
        view.scrollsToTop = false
        view.isPagingEnabled = true
        view.showsHorizontalScrollIndicator = false
        
        view.delegate = self
        view.dataSource  = self
        
        view.register(UICollectionViewCell.self, forCellWithReuseIdentifier: PAGE_CONTENT_COLLECTION_VIEW_IDENTIFIER)
        
        return view
    }()
    
    init(frame: CGRect, childVCs: [UIViewController], parentVC: UIViewController?) {
        self.childVCs = childVCs
        self.parentVC = parentVC
        
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension PageContentView {
    fileprivate func setupUI() {
        for childVC in childVCs {
            parentVC?.addChildViewController(childVC)
        }
        
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}

extension PageContentView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVCs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PAGE_CONTENT_COLLECTION_VIEW_IDENTIFIER, for: indexPath)
        
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        let childVC = childVCs[indexPath.row]
        childVC.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVC.view)
        
        return cell
    }
}

extension PageContentView: UICollectionViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isDisableScrollViewDelegate = false
        
        initialOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if isDisableScrollViewDelegate { return } 
        
        let count = childVCs.count
        let scrollViewW = scrollView.bounds.width
        let currentOffsetX = scrollView.contentOffset.x
        
        var progress: CGFloat = 0.0
        var sourceIndex = 0
        var targetIndex = 0
        
        // Left
        if currentOffsetX > initialOffsetX {
            progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)
            sourceIndex = Int(currentOffsetX / scrollViewW)
            targetIndex = sourceIndex + 1 >= count ? count : sourceIndex + 1
            
            if currentOffsetX - initialOffsetX == scrollViewW {
                progress = 1.0
                targetIndex = sourceIndex
            }
        } else {
            progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW))
            targetIndex = Int(currentOffsetX / scrollViewW)
            sourceIndex = sourceIndex + 1 >= count ? count : targetIndex + 1
        }
        
        delegate?.pageContentView(self, with: progress, from: sourceIndex, to: targetIndex)
    }
}

extension PageContentView {
    func setCurrentView(_ index: Int) {
        isDisableScrollViewDelegate = true
        
        let offsetX = collectionView.frame.width * CGFloat(index)
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    }
}
