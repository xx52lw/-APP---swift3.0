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
class LWLoginViewController: LWViewControllerBase {
    
    lazy var loginView: LWLoginView = {
        let view = LWLoginView()
//        view.delegate = self
        return view
    }()
    
    var qqAuth : TencentOAuth?
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
       qqAuth = TencentOAuth.init(appId: "101369721", andDelegate: self)
        view.addSubview(self.loginView)
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.loginView.frame = self.view.bounds
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
        navigationItem.title = "登录"
        // 取消按钮
        let cancelBtn = UIButton()
        cancelBtn.setTitle("取消", for: UIControlState.normal)
        cancelBtn.sizeToFit()
        cancelBtn.addTarget(self, action: #selector(dismissLoginView), for: UIControlEvents.touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: cancelBtn)
//        // 注册按钮
        let registerBtn = UIButton()
        registerBtn.setTitle("注册", for: UIControlState.normal)
        registerBtn.sizeToFit()
        registerBtn.addTarget(self, action: #selector(registerClick), for: UIControlEvents.touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: registerBtn)
    }
    // MARK:  取消点击事件
    func dismissLoginView() {
        
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    // MARK:  设置按钮点击事件
    func registerClick() {
        print("rightSettingClick")
        let permissions = ["get_user_info","get_simple_userinfo"]
        qqAuth?.authorize(permissions)
        
    }
    
    //// MARK: QQ授权
    func qqAuthorizeLogin() {
        
    }
    
    
    
}
// =================================================================================================================================
extension LWLoginViewController :  TencentSessionDelegate,TencentLoginDelegate {

    // 检测登录状态
    func tencentDidLogin() {
//        let token = qqAuth?.accessToken
        qqAuth?.getUserInfo()
    }
    // 用户信息回调
    func getUserInfoResponse(_ response: APIResponse!) {
        
        var info:Dictionary = response.jsonResponse
        
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
        infoModel.expirationDate = (qqAuth?.expirationDate.timeIntervalSinceReferenceDate)!
        
        // 此处应该有个请求把数据返回给自己后台
        
        SVProgressHUD.show(withStatus: "正在加载...")
       
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3.0) {
        
            SVProgressHUD.dismiss()
            
        }
        
        LWUserInfoModel.sharedInstance().saveUserInfo(infoModel)
        
        print(response)
        
    }
    func tencentDidNotNetWork() {
        
    }
    func tencentDidNotLogin(_ cancelled: Bool) {
        
    }

    
}

// =================================================================================================================================
