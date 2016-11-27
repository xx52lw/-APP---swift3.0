//
//  LWMeViewController.swift
//  dangtangDemo
//
//  Created by 张星星 on 16/11/22.
//  Copyright © 2016年 张星星. All rights reserved.
//

import UIKit

// =================================================================================================================================
// MARK: - 我的视图控制器
class LWMeViewController: LWViewControllerBase {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
        let bgImage = UIImage.getImageFromeBundleFile(fileName: "me", imageName: "Me_ProfileBackground")
        let bgView = UIImageView.init(image: bgImage)
        view.addSubview(bgView)
        
        
        
        // Do any additional setup after loading the view.
    }
    
}
// =================================================================================================================================
// MARK: - 我的视图
extension LWMeViewController {
    /// 设置导航条
    func setNavBar() {
        navigationItem.title = nil
        // 消息按钮
        let messageImage =  UIImage.getImageFromeBundleFile(fileName: "nav", imageName: "Nav_message")
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: UIButton.creatButtonWithNormalBgImage(messageImage, target: self, action: #selector(messageImageClick), for: UIControlEvents.touchUpInside))
        // 设置按钮
        let settingImage =  UIImage.getImageFromeBundleFile(fileName: "nav", imageName: "Nav_setting")
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: UIButton.creatButtonWithNormalBgImage(settingImage, target: self, action: #selector(rightSettingClick), for: UIControlEvents.touchUpInside))
        
    }
    /// 消息按钮点击事件
    func messageImageClick() {
        print("messageImageClick")
    }
    /// 设置按钮点击事件
    func rightSettingClick() {
        print("rightSettingClick")
    }
}
// =================================================================================================================================
