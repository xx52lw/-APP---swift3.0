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
class LWMeViewController: LWViewControllerBase, TencentSessionDelegate,TencentLoginDelegate {
    var qqAuth : TencentOAuth?
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isTranslucent = true
        self.edgesForExtendedLayout = UIRectEdge.all
        setNavBar()
        let bgImage = UIImage.getImageFromeBundleFile(fileName: "me", imageName: "Me_ProfileBackground")
        let bgView = UIImageView.init(image: bgImage)
        let url =  "http://7fvaoh.com3.z0.glb.qiniucdn.com/image/150817/cq0a0htx5_w.jpg-w720"
        //        bgView.kf.setImage(with: url, placeholder: bgImage, options: nil, progressBlock: nil, completionHandler: nil)
        view.addSubview(bgView)
        LWImageTool.imageUrlAndPlaceImage(imageView: bgView, stringUrl: url, placeholdImage: bgImage)
        
        qqAuth = TencentOAuth.init(appId: "101369721", andDelegate: self)
        
        // Do any additional setup after loading the view.
    }
    
    func tencentDidLogin() {
        let token = qqAuth?.accessToken
        qqAuth?.getUserInfo()
    }
    func getUserInfoResponse(_ response: APIResponse!) {
//        let info : NSDictionary = response.jsonResponse as NSDictionary
        let dic = response.userData
        var info:Dictionary = response.jsonResponse
        for value in info {
            print(value)
        }
        
    let model = LWNetWorkingTool<LWQQUserData>.getModel(dict: info as! Dictionary<String, Any>)
        
        let pic = model.nickname
        print("\(pic)")
        
        let sex = info["gender"] as! NSString
        let nickName = info["nickname"] as! String
        let headerPic = info["figureurl_qq_2"] as! String
        
        let infoModel = LWUserInfoModel.sharedInstance().getUserInfo()
        if sex.isEqual(to: "男") {
            infoModel.sex = 1
        }
        else {
            infoModel.sex = 2
        }
        infoModel.nickname = nickName
        infoModel.headerPic = headerPic
        LWUserInfoModel.sharedInstance().saveUserInfo(infoModel)
        print(response)
    }
    func tencentDidNotNetWork() {
        
    }
    func tencentDidNotLogin(_ cancelled: Bool) {
        
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
        let permissions = ["get_user_info","get_simple_userinfo"]
        qqAuth?.authorize(permissions)
        
    }
    
    
    
}
// =================================================================================================================================
