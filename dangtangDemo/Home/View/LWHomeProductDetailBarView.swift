//
//  LWHomeProductDetailBarView.swift
//  dangtangDemo
//
//  Created by liwei on 16/12/16.
//  Copyright © 2016年 张星星. All rights reserved.
//

import UIKit
// =================================================================================================================================
// MARK: - 产品详情页底部功能bar代理协议
protocol LWHomeProductDetailBarViewDelegate : NSObjectProtocol {
    /// 点击某项
    func homeProductDetailBarView(view: LWHomeProductDetailBarView, selectIndex: Int)
}
// =================================================================================================================================
// MARK: - 产品详情页底部功能bar数据源协议
protocol LWHomeProductDetailBarViewDataSource : NSObjectProtocol {
    
    /// 图片数组
    func homeProductDetailBarViewImageArrays(view: LWHomeProductDetailBarView) -> NSArray
    /// 描述数组
    func homeProductDetailBarViewTitleArrays(view: LWHomeProductDetailBarView) -> NSArray
    
}
// =================================================================================================================================
// MARK: - 产品详情页底部功能
class LWHomeProductDetailBarView: UIView {

    // 设置代理
    weak var delegate: LWHomeProductDetailBarViewDelegate?
    // 设置数据源
    weak var dataSource: LWHomeProductDetailBarViewDataSource!
    // 放置控件的视图
    lazy var allView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    // MARK: 重写init
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /// 更新控件
    func updateViews() {
        allView.removeFromSuperview()
        addSubview(allView)
    
        let imageArray = dataSource.homeProductDetailBarViewImageArrays(view: self)
        let titleArray = dataSource.homeProductDetailBarViewTitleArrays(view: self)
        let maxCount = max(imageArray.count, titleArray.count)
        let width = bounds.size.width / CGFloat(maxCount)
        let Y : CGFloat = 0.0
        let H : CGFloat = bounds.size.height
        
        for index in 0..<maxCount {
            var title : String?
            var image : UIImage?
            if index < imageArray.count {
                image = imageArray[index] as? UIImage
            }
            if index < titleArray.count {
                title = titleArray[index] as? String
            }
            let item = LWHomeProductDetailBarViewItem()
            item.frame = CGRect.init(x: width * CGFloat(index), y: Y, width: width, height: H)
            let imageW = image?.size.width
            let titleSize = LWUITool.sizeWithStringFont(title!, font: UIFont.systemFont(ofSize: 8), maxSize: CGSize.init(width: width, height: 200))
            var x = (width - (imageW! + titleSize.width + 5.0)) * 0.5
            var y = (H - (image?.size.height)!) * 0.5
            item.iconView.frame = CGRect.init(x: x, y: y, width: (image?.size.width)!, height: (image?.size.height)!)
            item.iconView.image = image
            
            x = item.iconView.frame.maxX + 5.0
            y = (H - titleSize.height) * 0.5
            item.titleLabel.frame = CGRect.init(x: x, y: y, width: titleSize.width, height: titleSize.height)
            item.titleLabel.text = title
            item.titleLabel.textColor = UIColor.gray
            item.titleLabel.font = UIFont.systemFont(ofSize: 8)
            addSubview(item)
        }
        
    }

}
// =================================================================================================================================
// MARK: 项元素
class LWHomeProductDetailBarViewItem: UIView {
    lazy var iconView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        return label
    }()
    // MARK: 重写init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(iconView)
        addSubview(titleLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// =================================================================================================================================
