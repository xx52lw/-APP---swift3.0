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

// 弹出登陆界面的通知
let LWShowLoginViewNotify = "LWShowLoginViewNotify"

// 首页频道数据加载完成的通知
let LWHomeChannlCompleteNotify = "LWHomeChannlCompleteNotify"
// 首页展示某个频道内容
let LWHomeShowChannlNotify = "LWHomeShowChannlNotify"
// 首页展示某个产品详情内容
let LWHomeShowProductNotify = "LWHomeShowProductNotify"

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
/// 全局默认占位图片
let LWGlobalPlaceHolderImage = UIImage.getImageFromeBundleFile(fileName: "comment", imageName: "PlaceHolderImage")






/// 存储用户信息的key
let kLWSaveUsernfoKey = "kLWSaveUsernfoKey"



/// 首页cell的比例
let LWHomeCellHeightWidth = CGFloat(329.0 / 720.0)
/// 分类集合cell的比例
let LHCategoryCellHeightWidth = CGFloat(147.0 / 300.0)



// ================================================================================================================================
