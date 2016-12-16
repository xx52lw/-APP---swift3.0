//
//  LWHomeProductDetailViewController.swift
//  dangtangDemo
//
//  Created by liwei on 16/12/16.
//  Copyright © 2016年 张星星. All rights reserved.
//

import UIKit
// =================================================================================================================================
// MARK: - 首页产品详情视图控制器
class LWHomeProductDetailViewController: LWViewControllerBase {

    // 懒加载webview
    lazy var webView: LWWebView = {
        let view = LWWebView()
        view.backgroundColor = UIColor.clear
        view.scrollView.delegate = self
        return view
    }()
    // 头部视图高度
    var headerImageHeight : CGFloat = 0.0
    // 头部背景图
    lazy var headerImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = UIColor.red
        view.contentMode = UIViewContentMode.scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    // 头部视图高度
    var titleHeight : CGFloat = 40.0
    // 标题
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.font = UIFont.systemFont(ofSize: 16.0)
        label.textColor = UIColor.white
        return label
    }()
    // 信息数据
    var info = LWHomeRequestDataInfo?()
    //MARK: 重写viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        headerImageHeight = view.frame.size.width * LWHomeCellHeightWidth  // 设置高度
        headerImageView.frame = CGRect.init(x: 0.0, y: 0.0, width: view.frame.size.width, height: headerImageHeight)
        LWImageTool.imageUrlAndPlaceImage(imageView: headerImageView, stringUrl: info?.cover_image_url, placeholdImage: LWGlobalPlaceHolderImage)
        view.addSubview(headerImageView)
        webView.scrollView.contentInset = UIEdgeInsetsMake(headerImageHeight, 0, 0, 0) // 设置网页向下
        view.addSubview(webView)
        webView.loadRequest(URLRequest.init(url: URL.init(string: (info?.content_url)!)!))
        titleLabel.frame = CGRect.init(x: 0.0, y: headerImageHeight - titleHeight, width: view.frame.size.width, height: titleHeight)
        titleLabel.text = info?.title
        view.addSubview(titleLabel)
        
    }
    //MARK: 重写viewWillLayoutSubviews
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        webView.frame = view.bounds
    }
}
// =================================================================================================================================
// MARK: - 首页产品详情视图控制器UIScrollViewDelegate
extension LWHomeProductDetailViewController : UIScrollViewDelegate {
    //MARK: 滚动视图
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y
        if y < -headerImageHeight {  // 下拉
            let h = headerImageHeight - (headerImageHeight + y)
            headerImageView.frame = CGRect.init(x: headerImageView.frame.origin.x, y: headerImageView.frame.origin.y, width: headerImageView.frame.size.width, height: h)
            titleLabel.frame = CGRect.init(x: titleLabel.frame.origin.x, y: h - titleHeight, width: titleLabel.frame.size.width, height: titleHeight)
        }
        else if (y >= -headerImageHeight && y <= 0) { // 上拉
            let h = headerImageHeight - (headerImageHeight + y) * 0.5
            headerImageView.frame = CGRect.init(x: headerImageView.frame.origin.x, y: headerImageView.frame.origin.y, width: headerImageView.frame.size.width, height: h)
            let titleH = headerImageHeight - (headerImageHeight + y) 
            titleLabel.frame = CGRect.init(x: titleLabel.frame.origin.x, y: titleH - titleHeight, width: titleLabel.frame.size.width, height: titleHeight)
        }
        else {
          
        }
    }
}
// =================================================================================================================================
