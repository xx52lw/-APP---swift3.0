//
//  LWUserInfoModel.swift
//  dangtangDemo
//
//  Created by 张星星 on 16/11/26.
//  Copyright © 2016年 张星星. All rights reserved.
//

import UIKit
import HandyJSON
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
    lazy var user: LWUserData = {
        let userDataModel = LWUserData()
        guard let dict = UserDefaults.standard.dictionary(forKey: LWUserInfoModelKey)
            else {
        return userDataModel
        }
//        userDataModel.sex = dict["sex"] as! Int
//        userDataModel.profession = dict["profession"] as! Int
        return LWNetWorkingTool<LWUserData>.getModel(dict: dict)
    }()
    
    /// 存储用户数据
    func saveUserInfo(_ userData : LWUserData?) {
        if userData == nil {
            user = LWUserData()
        }
        else {
            user = userData!
        }
        
        let dict = LWNetWorkingTool<LWUserData>.getDictinoary(model: userData)
        
//        
//        var dict = [String : AnyObject]()
//        dict["sex"] = user.sex as AnyObject?
//        dict["profession"] = user.profession as AnyObject?
        
        UserDefaults.standard.set(dict, forKey: LWUserInfoModelKey)
    
        
    }
    /// 获取用户数据
    func getUserInfo() -> LWUserData {
        return user
    }
    
//    static let path = (NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last! as NSString).appendingPathComponent("account.archive")
//    /// 一次性归档整个用户信息
//    func saveUserInfo() {
//        print("归档路径\(LWUserInfoModel.path)")
//        NSKeyedArchiver.archiveRootObject(self.user, toFile: LWUserInfoModel.path)
//    }
//    /// 一次性解档用户信息
//    class func readUserInfo() -> LWUserData? {
//        return NSKeyedUnarchiver.unarchiveObject(withFile: path) as? LWUserData
//    }
    
}
// ================================================================================================================================
// MARK: - 用户信息模型
class LWUserData: HandyJSON {
    
    /// 用户性别 1 男 2 女
    var sex : Int = 0
    /// 职业
    var profession : Int = 0
    
    required init() {
        
    }
    
//    ///MARK: 第三种方法
//    override var description: String {
//        let keys = ["sex","profession"]
//        return dictionaryWithValues(forKeys: keys).description
//    }
//    init(dictionary: [String: AnyObject]){
//        super.init()
//        
//        //字典转模型,kvc
//        setValuesForKeys(dictionary)
//    }
    
}
// ================================================================================================================================
