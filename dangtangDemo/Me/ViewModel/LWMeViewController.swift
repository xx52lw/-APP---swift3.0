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

               setNavBar()
        
        view.addSubview(self.headerView)
        
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        messageImageClick()
    }
    
    override func viewWillLayoutSubviews() {
         super.viewWillLayoutSubviews()
        let headerBgImage = UIImage.getImageFromeBundleFile(fileName: "me", imageName: "Me_ProfileBackground")
        var w = max(headerBgImage.size.width, 1)
        var h = max(headerBgImage.size.height, 1)
        if  w > self.view.frame.size.width {
            w = self.view.frame.size.width
            h =  (h / headerBgImage.size.width) * w
        }
        self.headerView.frame = CGRect.init(x: 0, y: 0, width: w, height: h)
        self.headerView.bgImageView.image = headerBgImage
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
        let detailVC = LWHomeProductDetailViewController()
        detailVC.url = "http://"
        navigationController?.pushViewController(detailVC, animated: true)
        
    }
    /// 设置按钮点击事件
    func rightSettingClick() {
        print("rightSettingClick")
//        let permissions = ["get_user_info","get_simple_userinfo"]
//        qqAuth?.authorize(permissions)
        
    }
    
    
    
}
// =================================================================================================================================
