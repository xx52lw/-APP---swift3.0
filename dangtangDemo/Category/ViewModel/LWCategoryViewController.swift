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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
        // Do any additional setup after loading the view.
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
}
// =================================================================================================================================
