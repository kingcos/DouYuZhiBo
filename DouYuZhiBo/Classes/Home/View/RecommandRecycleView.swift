//
//  RecommandRecycleView.swift
//  DouYuZhiBo
//
//  Created by 买明 on 25/04/2017.
//  Copyright © 2017 买明. All rights reserved.
//

import UIKit

class RecommandRecycleView: UIView {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var timer: Timer?
    
    var recycleModels: [RecycleModel]? {
        didSet {
            collectionView.reloadData()

            pageControl.numberOfPages = recycleModels?.count ?? 0
            
            let indexPath = IndexPath(item: (recycleModels?.count ?? 0) * 100, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
            
            removeTimer()
            addTimer()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        autoresizingMask = []
        
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(UINib(nibName: String(describing: RecycleCollectionCell.self),
                                                      bundle: nil),
                                forCellWithReuseIdentifier: RECOMMAND_RECYCLE_VIEW_IDENTIFIER)
//        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: RECOMMAND_RECYCLE_VIEW_IDENTIFIER)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        collectionView.isPagingEnabled = true
    }
}

extension RecommandRecycleView {
    class func create() -> RecommandRecycleView {
        return Bundle.main.loadNibNamed(String(describing: RecommandRecycleView.self),
                                        owner: nil,
                                        options: nil)?.first as! RecommandRecycleView
    }
}

extension RecommandRecycleView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (recycleModels?.count ?? 0) * 10000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RECOMMAND_RECYCLE_VIEW_IDENTIFIER, for: indexPath) as! RecycleCollectionCell

        cell.recycleModel = recycleModels![indexPath.row % (recycleModels?.count ?? 1)]
        
        return cell
    }
}

extension RecommandRecycleView: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        
        pageControl.currentPage = Int(offsetX / scrollView.bounds.width) % (recycleModels?.count ?? 1)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addTimer()
    }
}

extension RecommandRecycleView {
    func addTimer() {
        timer = Timer(timeInterval: 3.0,
                      target: self,
                      selector: .recycleTimerUpdate,
                      userInfo: nil,
                      repeats: true)
        
        RunLoop.main.add(timer!, forMode: .commonModes)
    }
    
    func removeTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc func timerUpdate() {
        let offsetX = collectionView.contentOffset.x + collectionView.bounds.width
        
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0.0), animated: true)
    }
}

extension Selector {
    static let recycleTimerUpdate = #selector(RecommandRecycleView.timerUpdate)
}
