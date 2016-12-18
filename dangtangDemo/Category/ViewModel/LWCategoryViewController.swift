//
//  LWCategoryViewController.swift
//  dangtangDemo
//
//  Created by 张星星 on 16/11/22.
//  Copyright © 2016年 张星星. All rights reserved.
//

import UIKit

// =================================================================================================================================
// MARK: - 分类视图控制器
class LWCategoryViewController: LWViewControllerBase {
    //MARK: 集合视图
    lazy var compilationView: LWCategoryCompilationsView = {
        let view = LWCategoryCompilationsView()
        view.backgroundColor = UIColor.white
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setNavBar()
        addViewSubviews()
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        layoutViewSubviews()
    }
}
// =================================================================================================================================
// MARK: - 分类视图
extension LWCategoryViewController {
    /// 设置导航条
    func setNavBar() {
        
        let searchImage =  UIImage.getImageFromeBundleFile(fileName: "nav", imageName: "Nav_search")
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: UIButton.creatButtonWithNormalBgImage(searchImage, target: self, action: #selector(rightSearchClick), for: UIControlEvents.touchUpInside))
        navigationItem.leftBarButtonItem = nil
    }
    func rightSearchClick() {
        print("rightSearchClick")
    }
    //MARK: 添加子控件
    func addViewSubviews() {
        compilationView.vc = self
        view.addSubview(compilationView)
    }
    //MARK: 布局子控件
    func layoutViewSubviews() {
        var x : CGFloat = 0.0
        var y : CGFloat = 0.0
        var w : CGFloat = view.frame.size.width
        var h : CGFloat = compilationView.getViewHeightWithLayoutViews(width: w)
        compilationView.frame = CGRect.init(x: x, y: y, width: w, height: h)
    }

}

// =================================================================================================================================
