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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
        // Do any additional setup after loading the view.
    }

}
// =================================================================================================================================
// MARK: - 首页视图
extension LWHomeViewController {
    /// 设置导航条
    func setNavBar() {

        let searchImage =  UIImage.getImageFromeBundleFile(fileName: "nav", imageName: "Nav_search")
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: UIButton.creatButtonWithNormalBgImage(searchImage, target: self, action: #selector(rightSearchClick), for: UIControlEvents.touchUpInside))

    }
    func rightSearchClick() {
        navigationController?.pushViewController(LWSearchViewController(), animated: true)
        print("rightSearchClick")
    }
}
// =================================================================================================================================
