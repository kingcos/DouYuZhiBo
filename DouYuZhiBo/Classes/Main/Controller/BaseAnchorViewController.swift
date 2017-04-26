//
//  BaseAnchorViewController.swift
//  DouYuZhiBo
//
//  Created by 买明 on 26/04/2017.
//  Copyright © 2017 买明. All rights reserved.
//

import UIKit

class BaseAnchorViewController: BaseViewController {
    
    var baseVM: BaseViewModel!
    
    lazy var collectionView: UICollectionView = { [weak self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: RECOMMAND_CELL_WIDTH, height: RECOMMAND_NORMAL_CELL_HEIGHT)
        layout.minimumLineSpacing = 0.0
        layout.minimumInteritemSpacing = RECOMMAND_CELL_MARGIN
        layout.sectionInset = UIEdgeInsetsMake(0.0, RECOMMAND_CELL_MARGIN, 0.0, RECOMMAND_CELL_MARGIN)
        layout.headerReferenceSize = CGSize(width: SCREEN_WIDTH, height: RECOMMAND_CELL_HEADER_HEIGHT)
        
        let view = UICollectionView(frame: self!.view.bounds, collectionViewLayout: layout)
        view.backgroundColor = .white
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        view.dataSource = self
        view.delegate = self
        
        view.register(UINib(nibName: String(describing: NormalCollectionCell.self),
                            bundle: nil),
                      forCellWithReuseIdentifier: RECOMMAND_NORMAL_CELL_IDENTIFIER)
        view.register(UINib(nibName: String(describing: YanZhiCollectionCell.self),
                            bundle: nil),
                      forCellWithReuseIdentifier: RECOMMAND_YANZHI_CELL_IDENTIFIER)
        view.register(UINib(nibName: String(describing: HeaderCollectionView.self),
                            bundle: nil),
                      forSupplementaryViewOfKind: UICollectionElementKindSectionHeader,
                      withReuseIdentifier: RECOMMAND_HEADER_VIEW_IDENTIFIER)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        loadData()
    }

}

extension BaseAnchorViewController {
    override func setupUI() {
        contentView = collectionView
        
        view.addSubview(collectionView)
        
        super.setupUI()
    }
    
    func loadData() {
    }
}

extension BaseAnchorViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return baseVM.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return baseVM.anchorGroups[section].anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RECOMMAND_NORMAL_CELL_IDENTIFIER, for: indexPath) as! NormalCollectionCell
        cell.anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: RECOMMAND_HEADER_VIEW_IDENTIFIER, for: indexPath) as! HeaderCollectionView

        headerView.group = baseVM.anchorGroups[indexPath.section]

        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.row]
        
        if anchor.isVertical == 0 {
            navigationController?.pushViewController(RoomNormalViewController(), animated: true)
        } else {
            present(RoomShowViewController(), animated: true)
        }
    }
}
