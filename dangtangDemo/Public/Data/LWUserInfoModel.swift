//
//  LWUserInfoModel.swift
//  dangtangDemo
//
//  Created by 张星星 on 16/11/26.
//  Copyright © 2016年 张星星. All rights reserved.
//

import UIKit
// ================================================================================================================================

private let LWUserInfoModelKey = "LWUserInfoModelKey"

// MARK: - 用户信息模型
class LWUserInfoModel: NSObject {

    /// 单例
    static let instance = LWUserInfoModel()
    class func sharedInstance() -> LWUserInfoModel {
        return instance
    }
    
    /// 用户数据
   private var user = LWUserData()
    
    /// 存储用户数据
    func saveUserInfo(_ userData : LWUserData?) {
        if userData == nil {
            user = LWUserData()
        }
        else {
            user = userData!
        }
        UserDefaults.standard.set(userData, forKey: LWUserInfoModelKey)
        
    }
    /// 获取用户数据
    func getUserInfo() -> LWUserData {
        return user
    }
    
}
// ================================================================================================================================
// MARK: - 用户信息模型
class LWUserData: NSObject {
    
    /// 用户性别 1 男 2 女
    var sex : Int = 0
    /// 职业
    var profession : Int = 0
    
}
// ================================================================================================================================
