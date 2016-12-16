//
//  LWNavigationControllerBase.swift
//  dangtangDemo
//
//  Created by 张星星 on 16/11/22.
//  Copyright © 2016年 张星星. All rights reserved.
//

import UIKit

class LWNavigationControllerBase: UINavigationController,UIGestureRecognizerDelegate,UINavigationControllerDelegate {

    // 默认是灰色，这里设置成白色
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    // 在info里面配置启动时候隐藏，这里要打开
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//      UIApplication.shared.statusBarStyle 
        // Do any additional setup after loading the view.
        // 默认是红色
        self.navigationBar.barTintColor = LWGlobalRed()
        // 设置title颜色
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        weak var wself = self
        if responds(to: #selector(getter: interactivePopGestureRecognizer)) {
            
            interactivePopGestureRecognizer?.delegate = wself as UIGestureRecognizerDelegate?
            self.delegate = wself as UINavigationControllerDelegate?
        }

    }
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
       
        if viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            
            let bgBtnImage = UIImage.getImageFromeBundleFile(fileName: "nav", imageName: "Nav_backward")
            let btn = UIButton()
//            let title = "  \(self.title! as String)"
            btn.setImage(bgBtnImage, for: UIControlState.normal)
            btn.setTitle(self.title, for: UIControlState.normal)
            btn.setTitleColor(UIColor.white, for: UIControlState.normal)
            btn.setTitleColor(UIColor.gray, for: UIControlState.highlighted)
            btn.sizeToFit()
            btn.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
            btn.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0)  // 返回箭头向左偏移，代替系统返回箭头位置
            btn.addTarget(self, action: #selector(backClick), for: UIControlEvents.touchUpInside)
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView:btn)
        }
        
        if (responds(to: #selector(getter: interactivePopGestureRecognizer)) && animated == true) {
            interactivePopGestureRecognizer?.isEnabled = false
        }
        
        
        super.pushViewController(viewController, animated: animated)
    }
    
  /// 返回按钮点击
    func backClick(){
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "lwBeignbackClick"), object: nil)
//        popViewController(animated: true)
    }
    
    override func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        if responds(to: #selector(getter: interactivePopGestureRecognizer)) {
            interactivePopGestureRecognizer?.isEnabled = false
        }
        return super.popToViewController(viewController, animated: animated)
    }
    
    override func popToRootViewController(animated: Bool) -> [UIViewController]? {
         if (responds(to: #selector(getter: interactivePopGestureRecognizer)) && animated == true) {
            interactivePopGestureRecognizer?.isEnabled = false
        }
       return super.popToRootViewController(animated: animated)
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        if responds(to: #selector(getter: interactivePopGestureRecognizer)) {
            if navigationController.childViewControllers.count < 2 {
                interactivePopGestureRecognizer?.isEnabled = false
            }
            else {
                interactivePopGestureRecognizer?.isEnabled = true
            }
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        otherGestureRecognizer.require(toFail: gestureRecognizer)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "lwBeignDrugViewController"), object: nil)
        return false
    }
    
}
