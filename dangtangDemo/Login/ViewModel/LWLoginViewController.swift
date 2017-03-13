//
//  LWLoginViewController.swift
//  dangtangDemo
//
//  Created by liwei on 17/3/13.
//  Copyright © 2017年 张星星. All rights reserved.
//

import UIKit
// =================================================================================================================================
// MARK: - 首页视图控制器
class LWLoginViewController: UIViewController , TencentSessionDelegate,TencentLoginDelegate{
    
    var qqAuth : TencentOAuth?
    override func viewDidLoad() {
        setNavBar()
        view.backgroundColor = UIColor.white
       qqAuth = TencentOAuth.init(appId: "101369721", andDelegate: self)
        
        let btn = UIButton.init()
        btn.frame = CGRect.init(x: 100, y: 100, width: 100, height: 100)
        btn.backgroundColor = UIColor.yellow
        btn.addTarget(self, action: #selector(dismissLoginView), for: UIControlEvents.touchUpInside)
        view .addSubview(btn)
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
        infoModel.appID = qqAuth?.accessToken ?? ""
        infoModel.expirationDate = qqAuth?.expirationDate.timeIntervalSinceReferenceDate
        LWUserInfoModel.sharedInstance().saveUserInfo(infoModel)
        
        print(response)
        
        
        
    }
    func tencentDidNotNetWork() {
        
    }
    func tencentDidNotLogin(_ cancelled: Bool) {
        
    }
    /// 设置按钮点击事件
    func rightSettingClick() {
        print("rightSettingClick")
        let permissions = ["get_user_info","get_simple_userinfo"]
        qqAuth?.authorize(permissions)
        
    }
}
// =================================================================================================================================
// MARK: - 登录界面视图
extension LWLoginViewController {
    
    /// 设置导航条
    func setNavBar() {
//        let searchImage =  UIImage.getImageFromeBundleFile(fileName: "nav", imageName: "Nav_search")
//        navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: UIButton.creatButtonWithNormalBgImage(searchImage, target: self, action: #selector(dismissLoginView), for: UIControlEvents.touchUpInside))
        navigationItem.title = "哈哈"
        // 取消按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "取消", style: UIBarButtonItemStyle.plain, target: self, action:#selector(dismissLoginView))
//        // 注册按钮
//        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "注册", style: UIBarButtonItemStyle.plain, target: self, action:#selector(registerClick))
//        
    }
    /// 取消点击事件
    func dismissLoginView() {
        
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    /// 设置按钮点击事件
    func registerClick() {
        print("rightSettingClick")
        let permissions = ["get_user_info","get_simple_userinfo"]
        qqAuth?.authorize(permissions)
        
    }
    
    
    
}
// =================================================================================================================================


// =================================================================================================================================
