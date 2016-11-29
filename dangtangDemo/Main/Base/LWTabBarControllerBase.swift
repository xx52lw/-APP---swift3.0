//
//  LWTabBarControllerBase.swift
//  dangtangDemo
//
//  Created by 张星星 on 16/11/22.
//  Copyright © 2016年 张星星. All rights reserved.
//

import UIKit
// =================================================================================================================================
// MARK: - 基础TabBar
class LWTabBarControllerBase: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpChildControllers()
    }

}
// =================================================================================================================================
// MARK: - 基础TabBar
extension LWTabBarControllerBase {
/// 设置主要的子控制器
    func setUpChildControllers() {
        
        var VCArrays = [UIViewController]()
        VCArrays.append(LWHomeNavigationController(rootViewController : createVC(imageName: "TabBar_home", tilteName: "单糖", vc: "LWHomeViewController")))
        VCArrays.append(LWGiftNavigationController(rootViewController : createVC(imageName: "TabBar_gift", tilteName: "单品", vc: "LWGiftViewController")))
        VCArrays.append(LWCategoryNavigationController(rootViewController : createVC(imageName: "TabBar_category", tilteName: "分类", vc: "LWCategoryViewController")))
        let info = LWUserInfoModel.sharedInstance().getUserInfo()
        if info.sex == 1 {
            VCArrays.append(LWMeNavigationController(rootViewController : createVC(imageName: "TabBar_me_boy", tilteName: "我", vc: "LWMeViewController")))
        }
        else {
            VCArrays.append(LWMeNavigationController(rootViewController : createVC(imageName: "TabBar_me_girl", tilteName: "我", vc: "LWMeViewController")))
        }
        viewControllers = VCArrays
    }
    func createVC(imageName : String,tilteName : String,vc : String) -> UIViewController {
        guard let vcClass = NSClassFromString(Bundle.main.nameSpace + "." + vc) as? LWViewControllerBase.Type
    
        else {
            return UIViewController()
        }
       // 创建控制器
        let classVC = vcClass.init()
        classVC.title = tilteName
        classVC.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName : LWGlobalRed()], for: .highlighted)
        classVC.tabBarItem.image = UIImage.getImageFromeBundleFile(fileName: "tabBar", imageName: imageName)
        classVC.tabBarItem.selectedImage = UIImage.getImageFromeBundleFile(fileName: "tabBar", imageName: imageName + "_selected").withRenderingMode(.alwaysOriginal)

       return classVC
        
    }
}
// =================================================================================================================================
