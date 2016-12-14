//
//  LWHomeViewController.swift
//  dangtangDemo
//
//  Created by 张星星 on 16/11/22.
//  Copyright © 2016年 张星星. All rights reserved.
//

import UIKit
// =================================================================================================================================
// MARK: - 首页视图控制器
class LWHomeViewController: LWViewControllerBase {
    
    // MARK: 懒加载频道选择View
    lazy var channelView: LWHomeChannelView = {
        let view = LWHomeChannelView()
        view.delegate = self
        view.backgroundColor = UIColor.white
        return view
    }()
    // MARK: 懒加载内容View
    lazy var contenView: LWHomeContentView = {
        let view = LWHomeContentView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
        // Do any additional setup after loading the view.
        view.addSubview(channelView)
        view.addSubview(contenView)
        NotificationCenter.default.addObserver(self, selector: #selector(homeChannlCompleteNotify), name: NSNotification.Name(rawValue: LWHomeChannlCompleteNotify), object: nil)
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        var x : CGFloat = 0.0
        var y : CGFloat = 0.0
        let w : CGFloat = view.frame.size.width
        var h : CGFloat = 40.0
        channelView.frame = CGRect.init(x: x, y: y, width: w, height: h)
        
        x = 0.0
        y = channelView.frame.maxY
        h = view.frame.size.height - y
        contenView.frame = CGRect.init(x: x, y: y, width: w, height: h)
        
        
    }
    
}
// =================================================================================================================================
// MARK: - 首页视图
extension LWHomeViewController {
    /// 设置导航条
    func setNavBar() {
        
        let searchImage =  UIImage.getImageFromeBundleFile(fileName: "nav", imageName: "Nav_search")
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: UIButton.creatButtonWithNormalBgImage(searchImage, target: self, action: #selector(rightSearchClick), for: UIControlEvents.touchUpInside))
        navigationItem.leftBarButtonItem = nil
        
    }
    func rightSearchClick() {
        navigationController?.pushViewController(LWSearchViewController(), animated: true)
        print("rightSearchClick")
    }
    // MARK: 接收到频道数据加载完成的通知
    func homeChannlCompleteNotify(notify: NSNotification){
        print(notify.object)
        guard let array : NSArray = notify.object as! NSArray? else {
            return
        }
        if array.count <= 0 {
            return
        }
        contenView.createShowView(viewArrays: array)
    }
}
// =================================================================================================================================
// MARK: - 首页视图
extension LWHomeViewController : LWHomeChannelViewDelegate {
    /// 选择某个频道
    func homeChannelView(view: LWHomeChannelView, selectIndex: Int) {
        print(selectIndex)
    }
    /// 选择选择按钮
    func homeChannelView(view: LWHomeChannelView, selectBtn: UIButton) {
        
    }
}
// =================================================================================================================================
