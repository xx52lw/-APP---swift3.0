//
//  LWGiftData.swift
//  dangtangDemo
//
//  Created by 张星星 on 16/11/29.
//  Copyright © 2016年 张星星. All rights reserved.
//

import UIKit

/// 请求Url
let LWGiftDataUrl = "http://api.dantangapp.com/v2/items"
// ================================================================================================================================
// MARK: 单品首页数据的请求参数
class LWGiftData: LWServiceBase {
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
// MARK: 单品首页数据的响应数据
class LWGiftRequestData: LWServiceBase {
    /// 数据数组
    var items : [LWGiftRequestDataModel]?
    var paging : LWGiftRequestDataPaging?
    required init() {
        
    }
}
// ================================================================================================================================
// MARK: 数组中数据
class LWGiftRequestDataModel: LWServiceBase {
    ///
    var data : LWGiftRequestDataInfo?
    var type : String?
    
    required init() {
        
    }
}
// ================================================================================================================================
// MARK: 详细数据
class LWGiftRequestDataInfo: LWServiceBase {
    var brand_order : Int?
    var cover_image_url : String?
    var created_at : Int?
    var description : String?
    var editor_id : Int?
    var favorites_count : Int?
    var id : Int?
    var image_urls : [String]?
    var name : String?
    var price : String?
    var purchase_id : String?
    var purchase_url : String?
    var url : String?
//    func mapping(mapper: HelpingMapper) {
//        // specify 'data_id' field in json map to 'id' property in object
//        mapper.specify(property: &id, name: "data_id")
//    }
    
    required init() {
        
    }
}
// ================================================================================================================================
// MARK:
class LWGiftRequestDataPaging: LWServiceBase {
    
    var next_url : String?
    
    required init() {
        
    }
}
// ================================================================================================================================

