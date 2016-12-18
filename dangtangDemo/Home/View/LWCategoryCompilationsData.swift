//
//  LWCategoryCompilationsData.swift
//  dangtangDemo
//
//  Created by liwei on 16/12/18.
//  Copyright © 2016年 张星星. All rights reserved.
//

import UIKit
/// 请求Url
let LWCategoryCompilationsDataUrl = "http://api.dantangapp.com/v1/collections?"
// ================================================================================================================================
// MARK: 单品分类专题合集数据的请求数据
class LWCategoryCompilationsData: LWServiceBase {
    /// 每页数量
    var limit : Int = 20
    /// 页码
    var offset: Int = 0
    
    required init() {
        
    }

}

// ================================================================================================================================
// MARK: 单品分类专题合集数据的响应数据
class LWCategoryCompilationsRequestData: LWServiceBase {
    /// 数据数组
    var collections : [LWCategoryCompilationsRequestDataInfo]?
    var paging : LWCategoryCompilationsRequestDataPaging?
    required init() {
        
    }
}
// ================================================================================================================================
// MARK: 详细数据
class LWCategoryCompilationsRequestDataInfo: LWServiceBase {
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
// MARK:
class LWCategoryCompilationsRequestDataPaging: LWServiceBase {
    
    var next_url : String?
    
    required init() {
        
    }
}
// ================================================================================================================================
