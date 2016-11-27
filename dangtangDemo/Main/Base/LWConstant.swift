//
//  LWConstant.swift
//  dangtangDemo
//
//  Created by 张星星 on 16/11/23.
//  Copyright © 2016年 张星星. All rights reserved.
//

import UIKit

// ================================================================================================================================
// // MARK: - 类似OC的宏定义





// 新特性完成的通知
let LWNewFeatureCompleteNotify = "LWNewFeatureCompleteNotify"



// 之前系统的版本
let LWSystemVersionKey = "LWSystemVersionKey"

/// 屏幕宽度
let LWAppScreenWidth = UIScreen.main.bounds.size.width
/// 屏幕高度
let LWAppScreenHeight = UIScreen.main.bounds.size.height
/// 自定义颜色
func LWRGB( _ r : CGFloat , g : CGFloat ,b : CGFloat) -> UIColor {
    return UIColor.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0  , alpha: 1.0)
}

/// 全局的背景颜色
func LWGlobalViewBgColor() -> UIColor {
return LWRGB(240, g: 240, b: 240)
}
/// 全局的红
func LWGlobalRed() -> UIColor {
    return LWRGB(245, g: 80, b: 83)
}












/// 存储用户信息的key
let kLWSaveUsernfoKey = "kLWSaveUsernfoKey"
// ================================================================================================================================
