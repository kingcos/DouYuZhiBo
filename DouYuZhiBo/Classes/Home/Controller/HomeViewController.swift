//
//  HomeViewController.swift
//  DouYuZhiBo
//
//  Created by 买明 on 23/04/2017.
//  Copyright © 2017 买明. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    lazy var pageTitleView: PageTitleView = { [weak self] in
        let frame = CGRect(x: 0.0, y: STATUS_BAR_HEIGHT + NAVIGATION_BAR_HEIGHT, width: SCREEN_WIDTH, height: TITLE_VIEW_HEIGHT)
        let titles = ["推荐", "游戏", "娱乐", "趣玩"]
        let view = PageTitleView(frame: frame, titles: titles)
        view.delegate = self
        return view
    }()

    lazy var pageContentView: PageContentView = {
        let viewY = STATUS_BAR_HEIGHT + NAVIGATION_BAR_HEIGHT + TITLE_VIEW_HEIGHT
        let viewH = SCREEN_HEIGHT - viewY - TAB_BAR_HEIGHT
        let viewFrame = CGRect(x: 0.0, y: viewY, width: SCREEN_WIDTH, height: viewH)
        
        var childVCs = [UIViewController]()
        
        childVCs.append(RecommandViewController())
        childVCs.append(GameViewController())
        childVCs.append(EntertainmentViewController())
        childVCs.append(FunViewController())
        
        let view = PageContentView(frame: viewFrame, childVCs: childVCs, parentVC: self)
        view.delegate = self
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
}

extension HomeViewController {
    fileprivate func setupUI() {
        automaticallyAdjustsScrollViewInsets = false
        
        setupNavigationBar()
        
        view.addSubview(pageTitleView)
        view.addSubview(pageContentView)
        
        pageContentView.backgroundColor = .purple
    }
    
    private func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "homeLogoIcon_62x26_")
        
        let size = CGSize(width: 40.0, height: 40.0)
        let historyBarItem = UIBarButtonItem(imageName: "viewHistoryIcon_20x20_", selectedImageName: "viewHistoryIconHL_20x20_", size: size)
        let searchBarItem = UIBarButtonItem(imageName: "searchBtnIcon_20x20_", selectedImageName: "searchBtnIconHL_20x20_", size: size)
        let scanBarItem = UIBarButtonItem(imageName: "scanIcon_20x20_", selectedImageName: "scanIconHL_20x20_", size: size)
        
        navigationItem.rightBarButtonItems = [historyBarItem, searchBarItem, scanBarItem]
    }
}

extension HomeViewController: PageTitleViewDelegate {
    func pageTitleView(_ view: PageTitleView, selected index: Int) {
        pageContentView.setCurrentView(index)
    }
}

extension HomeViewController: PageContentViewDelegate {
    func pageContentView(_ view: PageContentView, with progress: CGFloat, from sourceIndex: Int, to targetIndex: Int) {
//        print("\(progress) - \(sourceIndex) - \(targetIndex)")
        pageTitleView.setTitleView(progress, from: sourceIndex, to: targetIndex)
    }
}
