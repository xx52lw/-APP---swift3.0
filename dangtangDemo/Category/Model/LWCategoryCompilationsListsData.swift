//
//  LWCategoryCompilationsListsData.swift
//  dangtangDemo
//
//  Created by liwei on 16/12/18.
//  Copyright © 2016年 张星星. All rights reserved.
//

import UIKit
/// 请求Urlhttp://api.dantangapp.com/v1/collections/4/posts?gender=1&generation=1&limit=20&offset=0
let LWCategoryCompilationsListsDataUrl = "http://api.dantangapp.com/v1/collections/"
// ================================================================================================================================
// MARK: 单品分类专题合集列表数据的请求数据
class LWCategoryCompilationsListsData: LWServiceBase {
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
class LWCategoryCompilationsListsRequestData: LWServiceBase {
    /// 数据数组
    var posts : [LWCategoryCompilationsListsRequestDataInfo]?
    var paging : LWCategoryCompilationsListsRequestDataPaging?
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
// MARK: 详细数据
class LWCategoryCompilationsListsRequestDataInfo: LWServiceBase {
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
class LWCategoryCompilationsListsRequestDataPaging: LWServiceBase {
    
    var next_url : String?
    
    required init() {
        
    }
}
// ================================================================================================================================

