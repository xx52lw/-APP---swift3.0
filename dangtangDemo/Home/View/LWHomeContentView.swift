//
//  LWHomeContentView.swift
//  dangtangDemo
//
//  Created by liwei on 16/12/10.
//  Copyright © 2016年 张星星. All rights reserved.
//

import UIKit
// =================================================================================================================================
// MARK: - 首页频道展示视图
class LWHomeContentView: UIView {

    // MARK: 视图数组
     var viewArray: NSArray?
    // MARK: 懒加载滚动View
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.isPagingEnabled = true
        view.bounces = false
        return view
    }()

    // MARK: 懒加载内容View
    lazy var contenView: LWHomeBannerTableView = {
        let view = LWHomeBannerTableView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    // MARK: 重写系统init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(scrollView)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: 重写系统layoutSubviews
    override func layoutSubviews() {
        super.layoutSubviews()
        scrollView.frame = self.bounds
    }

    
    
}
// =================================================================================================================================
// MARK: - 首页频道展示视图
extension LWHomeContentView {
    /// 创建展示视图
    func createShowView(viewArrays : NSArray) {
        let viewCount = viewArrays.count
        if viewCount <= 0 {
            return
        }
        for view in scrollView.subviews {
            if view.isKind(of: UIView.self) {
                view.removeFromSuperview()
            }
        }
        var showCount : CGFloat = 0
        let scrollViewWidth = scrollView.frame.size.width
        let scrollViewHeight = scrollView.frame.size.height
        for index in 0..<viewCount {
            guard let info = viewArrays[index] as? LWHomeChannelRequestInfo else {
                return
            }
            if info.editable == false {
                return
            }
            if index == 0 {
                let bannerTableView = LWHomeBannerTableView()
                bannerTableView.frame = CGRect.init(x: scrollViewWidth * showCount, y: 0.0, width: scrollViewWidth, height: scrollViewHeight)
                bannerTableView.bannerInfo = info
                bannerTableView.tag = index
                bannerTableView.showView()
                scrollView.addSubview(bannerTableView)
            }
            else {
                let tableView = LWHomeTableView()
                tableView.frame = CGRect.init(x: scrollViewWidth * showCount, y: 0.0, width: scrollViewWidth, height: scrollViewHeight)
                tableView.bannerInfo = info
                tableView.tag = index
                scrollView.addSubview(tableView)
            }
            showCount = showCount + 1.0
        }
        scrollView.contentSize = CGSize.init(width: scrollViewWidth * showCount, height: scrollViewHeight)
        
    }
}
// =================================================================================================================================
