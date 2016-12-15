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
protocol LWHomeContentViewDelegate : NSObjectProtocol {
    // 滚动到某个频道
    func homeContentView(view : LWHomeContentView, scrollToIndex: Int)
}
// =================================================================================================================================
// MARK: - 首页频道展示视图
class LWHomeContentView: UIView {
    // MARK: 设置代理
    weak var delegate : LWHomeContentViewDelegate?
    // MARK: 视图数组
     var viewArray: NSArray?
    // MARK: 视图展示的索引
    var showIndex = 0
    // MARK: 懒加载滚动View
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.isPagingEnabled = true
        view.bounces = false
        view.delegate = self
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

    // MARK: 滚动到相应的位置
    func scollShowView(index: NSInteger,info: LWHomeChannelRequestInfo?) {
        if (index >= (viewArray?.count)!) {
            return
        }
        scrollView.contentOffset = CGPoint.init(x: scrollView.frame.size.width * CGFloat(index), y: 0)
        guard let info = viewArray?[index] as? LWHomeChannelRequestInfo else {
            return
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: LWHomeShowChannlNotify), object:info)
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
        viewArray = viewArrays
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
            info.index = index
            if index == 0 {
                let bannerTableView = LWHomeBannerTableView()
                bannerTableView.frame = CGRect.init(x: scrollViewWidth * showCount, y: 0.0, width: scrollViewWidth, height: scrollViewHeight)
                bannerTableView.bannerInfo = info
                bannerTableView.tag = index
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
        let info = viewArrays[showIndex] as? LWHomeChannelRequestInfo
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: LWHomeShowChannlNotify), object:info)
        scrollView.contentSize = CGSize.init(width: scrollViewWidth * showCount, height: scrollViewHeight)
        scrollView.contentOffset = CGPoint.init(x: scrollView.frame.size.width * CGFloat(showIndex), y: 0)
        
    }
}
// =================================================================================================================================
// MARK: - 首页频道展示视图
extension LWHomeContentView : UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var index  = Int((scrollView.contentOffset.x + scrollView.frame.size.width * 0.5) / scrollView.frame.size.width)
        if index <= 0 {
            index = 0
        }
        if (index > ((viewArray?.count)! - 1)){
            index = (viewArray?.count)! - 1
        }
        guard let info = viewArray?[index] as? LWHomeChannelRequestInfo else {
            return
        }
        delegate?.homeContentView(view: self, scrollToIndex: index)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: LWHomeShowChannlNotify), object:info)
    }
}
// =================================================================================================================================
