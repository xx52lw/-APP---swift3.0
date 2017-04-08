//
//  LWMeViewController.swift
//  dangtangDemo
//
//  Created by 张星星 on 16/11/22.
//  Copyright © 2016年 张星星. All rights reserved.
//

import UIKit
import HandyJSON
// =================================================================================================================================
// MARK: - 我的视图控制器
class LWMeViewController: LWViewControllerBase {
    
    // 消息按钮
    lazy var messageBtn: UIButton = {
        let messageImage =  UIImage.getImageFromeBundleFile(fileName: "nav", imageName: "Nav_message")
        let messageBtn = UIButton.creatButtonWithNormalBgImage(messageImage, target: self, action: #selector(messageImageClick), for: UIControlEvents.touchUpInside)
        return messageBtn
    }()
    // 设置按钮
    lazy var settingBtn: UIButton = {
        let settingImage =  UIImage.getImageFromeBundleFile(fileName: "nav", imageName: "Nav_setting")
        let settingBtn = UIButton.creatButtonWithNormalBgImage(settingImage, target: self, action: #selector(rightSettingClick), for: UIControlEvents.touchUpInside)
        return settingBtn
    }()
    // 懒加载头像视图
    lazy var headerView : LWMeHeaderView = {
       let view = LWMeHeaderView()
        view.backgroundColor = UIColor.clear
        let infoModel = LWUserInfoModel.sharedInstance().getUserInfo()
        let placeholdImage = UIImage.getImageFromeBundleFile(fileName: "me", imageName: "Me_AvatarPlaceholder")
        LWImageTool.imageUrlAndPlaceImage(imageView: view.headerImageView, stringUrl: infoModel.headerPic, placeholdImage: placeholdImage)
        view.nickLabel.text = infoModel.nickname.characters.count > 0 ? infoModel.nickname : "登录"
        return view
    }()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
 
        // 此处坑了我好久，侧滑返回bug.解决问题的关键，我们之前一直使用self.navigationController.navigationBarHidden或者self.navigationController.navigationBar.hidden来隐藏navigatiuonbar，这样直接更改属性的方式是不带动画的，而且滑动时的转场动画页不为我们处理好，才导致了问出的出现
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        view.addSubview(self.headerView)
        
        
        setNavBar()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillLayoutSubviews() {
         super.viewWillLayoutSubviews()
        let headerBgImage = UIImage.getImageFromeBundleFile(fileName: "me", imageName: "Me_ProfileBackground")
        var w = max(headerBgImage.size.width, 1)
        var h = max(headerBgImage.size.height, 1)
        if  w > self.view.frame.size.width || w < self.view.frame.size.width{
            w = self.view.frame.size.width
            h =  (h / headerBgImage.size.width) * w
        }
        self.headerView.frame = CGRect.init(x: 0, y: 0, width: w, height: h)
        self.headerView.bgImageView.image = headerBgImage
        var x : CGFloat = 10.0
        var y : CGFloat = 30.0
        w = messageBtn.frame.size.width
        h = messageBtn.frame.size.height
        messageBtn.frame = CGRect.init(x: x, y: y, width: w, height: h)
        
        w = settingBtn.frame.size.width
        h = settingBtn.frame.size.height
        x = view.frame.size.width - w - 10.0
        settingBtn.frame = CGRect.init(x: x, y: y, width: w, height: h)
    }
    
}
// =================================================================================================================================
// MARK: - 我的视图
extension LWMeViewController {
    
    /// 设置导航条
    func setNavBar() {
    
        view.addSubview(self.messageBtn)
       view.addSubview(self.settingBtn)
        
    }
    /// 消息按钮点击事件
    func messageImageClick() {
        print("messageImageClick")
        
    }
    /// 设置按钮点击事件
    func rightSettingClick() {
        print("rightSettingClick")
        let vc = LWMeSettingViewController()
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
}
// =================================================================================================================================
