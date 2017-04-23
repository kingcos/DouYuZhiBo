//
//  PageTitleView.swift
//  DouYuZhiBo
//
//  Created by 买明 on 23/04/2017.
//  Copyright © 2017 买明. All rights reserved.
//

import UIKit

protocol PageTitleViewDelegate: class {
    func pageTitleView(_ view: PageTitleView, selected index: Int)
}

class PageTitleView: UIView {
    
    weak var delegate: PageTitleViewDelegate?
    
    var titles: [String]
    var currentIndex = 0
    
    lazy var titleLabels = [UILabel]()
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsHorizontalScrollIndicator = false
        view.scrollsToTop = false
        view.bounces = false
        
        return view
    }()
    
    lazy var underlineView: UIView = {
        let view = UIView()
        view.backgroundColor = .orange
        return view
    }()

    init(frame: CGRect, titles: [String]) {
        self.titles = titles
        
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension PageTitleView {
    fileprivate func setupUI() {
        
        
        addSubview(scrollView)
        scrollView.frame = bounds
        
        setupTitleLabels()
        
        setupUnderlines()
    }
    
    fileprivate func setupTitleLabels() {
        let labelW = frame.width / CGFloat(titles.count)
        let labelH = frame.height - PAGE_TITLE_VIEW_UNDERLINE_HEIGHT
        let labelY: CGFloat = 0.0
        
        for (index, title) in titles.enumerated() {
            let label = UILabel()
            let labelX = labelW * CGFloat(index)
            
            label.text = title
            label.tag = index
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textColor = UIColor(r: PAGE_TITLE_LABEL_NORMAL_COLOR.0,
                                      g: PAGE_TITLE_LABEL_NORMAL_COLOR.1,
                                      b: PAGE_TITLE_LABEL_NORMAL_COLOR.2)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            titleLabels.append(label)
            scrollView.addSubview(label)
            
            let tapGesture = UITapGestureRecognizer(target: self, action: .tapedPageTitleLabel)
            label.isUserInteractionEnabled = true
            label.addGestureRecognizer(tapGesture)
        }
    }
    
    fileprivate func setupUnderlines() {
//        let underline = UIView()
//        let underlineH: CGFloat = 0.5
//        let underlineW = frame.width
//        let underlineY = frame.height - underlineH
//        
//        underline.backgroundColor = .lightGray
//        underline.frame = CGRect(x: 0.0, y: underlineY, width: underlineW, height: underlineH)
//        
//        addSubview(underline)
        
        guard let firstLabel = titleLabels.first else { return }
        firstLabel.textColor = UIColor(r: PAGE_TITLE_LABEL_HIGHLIGHTED_COLOR.0,
                                       g: PAGE_TITLE_LABEL_HIGHLIGHTED_COLOR.1,
                                       b: PAGE_TITLE_LABEL_HIGHLIGHTED_COLOR.2)
        
        scrollView.addSubview(underlineView)
        underlineView.frame = CGRect(x: firstLabel.frame.origin.x,
                                     y: frame.height - PAGE_TITLE_VIEW_UNDERLINE_HEIGHT,
                                     width: firstLabel.frame.width,
                                     height: PAGE_TITLE_VIEW_UNDERLINE_HEIGHT)
    }
}

extension Selector {
    static let tapedPageTitleLabel = #selector(PageTitleView.tapedPageTitleLabel(_:))
}

extension PageTitleView {
    @objc fileprivate func tapedPageTitleLabel(_ gesture: UITapGestureRecognizer) {
        guard let label = gesture.view as? UILabel else { return }
        guard label.tag != currentIndex else { return }
        
        let sourceLabel = titleLabels[currentIndex]
        
        label.textColor = UIColor(r: PAGE_TITLE_LABEL_HIGHLIGHTED_COLOR.0,
                                  g: PAGE_TITLE_LABEL_HIGHLIGHTED_COLOR.1,
                                  b: PAGE_TITLE_LABEL_HIGHLIGHTED_COLOR.2)
        sourceLabel.textColor = UIColor(r: PAGE_TITLE_LABEL_NORMAL_COLOR.0,
                                        g: PAGE_TITLE_LABEL_NORMAL_COLOR.1,
                                        b: PAGE_TITLE_LABEL_NORMAL_COLOR.2)
        currentIndex = label.tag
        
        let underlineX = underlineView.frame.width * CGFloat(currentIndex)
        
        UIView.animate(withDuration: 0.15) { [weak self] in
            self?.underlineView.frame.origin.x = underlineX
        }
        
        delegate?.pageTitleView(self, selected: currentIndex)
    }
}

extension PageTitleView {
    func setTitleView(_ progress: CGFloat, from sourceIndex: Int, to targetIndex: Int) {
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        
        let totalMovedX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let movedX = totalMovedX * progress
        
        underlineView.frame.origin.x = sourceLabel.frame.origin.x + movedX
        
        let colorRange = (PAGE_TITLE_LABEL_HIGHLIGHTED_COLOR.0 - PAGE_TITLE_LABEL_NORMAL_COLOR.0,
                          PAGE_TITLE_LABEL_HIGHLIGHTED_COLOR.1 - PAGE_TITLE_LABEL_NORMAL_COLOR.1,
                          PAGE_TITLE_LABEL_HIGHLIGHTED_COLOR.2 - PAGE_TITLE_LABEL_NORMAL_COLOR.2)
        
        sourceLabel.textColor = UIColor(r: PAGE_TITLE_LABEL_HIGHLIGHTED_COLOR.0 - colorRange.0 * progress,
                                        g: PAGE_TITLE_LABEL_HIGHLIGHTED_COLOR.1 - colorRange.1 * progress,
                                        b: PAGE_TITLE_LABEL_HIGHLIGHTED_COLOR.2 - colorRange.2 * progress)
        targetLabel.textColor = UIColor(r: PAGE_TITLE_LABEL_NORMAL_COLOR.0 + colorRange.0 * progress,
                                        g: PAGE_TITLE_LABEL_NORMAL_COLOR.1 + colorRange.1 * progress,
                                        b: PAGE_TITLE_LABEL_NORMAL_COLOR.2 + colorRange.2 * progress)
        currentIndex = targetIndex
    }
}
