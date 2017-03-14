//
//  LWCommonGlobalTool.swift
//  dangtangDemo
//
//  Created by liwei on 17/3/14.
//  Copyright © 2017年 张星星. All rights reserved.
//  公共的全局工具

import UIKit
// =================================================================================================================================
class LWCommonGlobalTool: NSObject {

    /// 共享单例
    static let instance = LWCommonGlobalTool()
    class func sharedInstance() -> LWCommonGlobalTool {
        return instance
    }
    /// 添加通知
    func addCommonNotify()  {
        removeCommonNotify()
        NotificationCenter.default.addObserver(self, selector: #selector(showLoginView), name: NSNotification.Name(rawValue: LWShowLoginViewNotify), object: nil);
    }
    /// 移除通知
    func removeCommonNotify() {
        NotificationCenter.default.removeObserver(self)
    }
}
// =================================================================================================================================
// MARK: - 全局工具
extension LWCommonGlobalTool {
    // MARK: 展示登陆界面
    func showLoginView() {
        let nav = LWNavigationControllerBase(rootViewController:LWLoginViewController())
       let rootViewController = UIApplication.shared.keyWindow?.rootViewController
      rootViewController?.present(nav, animated: true, completion: nil)
    }
}
// =================================================================================================================================
