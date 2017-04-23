
//
//  RecommandViewController.swift
//  DouYuZhiBo
//
//  Created by 买明 on 23/04/2017.
//  Copyright © 2017 买明. All rights reserved.
//

import UIKit

class RecommandViewController: UIViewController {
    
    lazy var collectionView: UICollectionView = { [weak self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: RECOMMAND_CELL_WIDTH, height: RECOMMAND_CELL_HEIGHT)
        layout.minimumLineSpacing = 0.0
        layout.minimumInteritemSpacing = RECOMMAND_CELL_MARGIN
        layout.sectionInset = UIEdgeInsetsMake(0.0, RECOMMAND_CELL_MARGIN, 0.0, RECOMMAND_CELL_MARGIN)
        layout.headerReferenceSize = CGSize(width: SCREEN_WIDTH, height: RECOMMAND_CELL_HEADER_HEIGHT)

        let view = UICollectionView(frame: self!.view.bounds, collectionViewLayout: layout)
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        view.dataSource = self
        
        view.register(UICollectionViewCell.self, forCellWithReuseIdentifier: RECOMMAND_COLLECTION_VIEW_IDENTIFIER)
        view.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: RECOMMAND_HEADER_VIEW_IDENTIFIER)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
}

extension RecommandViewController {
    func setupUI() {
        view.addSubview(collectionView)
        
        
    }
}

extension RecommandViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 8
        }
        
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RECOMMAND_COLLECTION_VIEW_IDENTIFIER, for: indexPath)
        cell.backgroundColor = .red
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: RECOMMAND_HEADER_VIEW_IDENTIFIER, for: indexPath)
        headerView.backgroundColor = .green
        return headerView
    }
}
