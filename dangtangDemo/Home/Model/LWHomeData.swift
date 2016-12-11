//
//  LWHomeData.swift
//  dangtangDemo
//
//  Created by liwei on 16/12/10.
//  Copyright © 2016年 张星星. All rights reserved.
//

import UIKit
/// 请求Url "http://api.dantangapp.com/v1/channels/4/items"
let LWHomeDataUrl = "http://api.dantangapp.com/v1/channels/"
// ================================================================================================================================
// MARK: 首页数据的请求参数
class LWHomeData: LWServiceBase {
    /// 性别
    var gender : Int?
    var generation : Int?
    /// 每页数量
    var limit : Int = 20
    /// 页码
    var offset: Int = 0
    
    required init() {
        
    }

}
// ================================================================================================================================
// MARK: 首页数据的响应数据
class LWHomeRequestData: LWServiceBase {
    /// 数据数组
    var items : [LWHomeRequestDataInfo]?
    var paging : LWHomeRequestDataPaging?
    required init() {
        
    }
}
// ================================================================================================================================
// MARK: 详细数据
class LWHomeRequestDataInfo: LWServiceBase {
    var content_url : String?
    var cover_image_url : String?
    var created_at : Int?
    var description : String?
    var editor_id : Int?
    var id : Int?
    var liked : Bool?
    var likes_count : Int?
    var published_at : Int?
    var share_msg : [String]?
    var short_title : String?
    var status : Int?
    var template : String?
    var title : String?
    var type : String?
    var updated_at : Int?
    var url : String?
    
    required init() {
        
    }
}
// ================================================================================================================================
// MARK:
class LWHomeRequestDataPaging: LWServiceBase {
    
    var next_url : String?
    
    required init() {
        
    }
}
// ================================================================================================================================


// ================================================================================================================================
