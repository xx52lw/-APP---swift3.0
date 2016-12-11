//
//  LWHomeBannerData.swift
//  dangtangDemo
//
//  Created by liwei on 16/12/10.
//  Copyright © 2016年 张星星. All rights reserved.
//

import UIKit

/// 请求Url
let LWHomeBannerDataUrl = "http://api.dantangapp.com/v1/banners?channel=iOS"
// ================================================================================================================================
// MARK: 单品首页数据的响应数据

class LWHomeBannerData: LWServiceBase {
    /// 数据数组
    var banners : [LWHomeBannerRequestData]?
    required init() {
        
    }

    
}
// ================================================================================================================================
// MARK: 单品首页数据的响应数据
class LWHomeBannerRequestData: LWServiceBase {
    /// 数据数组
    var channel : String?
    var id : Int?
    var image_url : String?
    var order : Int?
    var status : Int?
    var target : LWHomeBannerTargetData?
    var target_id : Int?
    var target_url : String?
    var type : String?

    required init() {
        
    }
}
// ================================================================================================================================
// MARK: 单品首页数据的响应数据
class LWHomeBannerTargetData: LWServiceBase {

    var banner_image_url : String?
    var cover_image_url : String?
    var created_at : Int?
    var id : Int?
    var posts_count : Int?
    var status : Int?
    var subtitle : String?
    var title : String?
    var updated_at : Int?
    
    required init() {
        
    }
}
// ================================================================================================================================
