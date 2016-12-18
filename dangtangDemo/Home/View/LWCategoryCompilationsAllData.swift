//
//  LWCategoryCompilationsAllData.swift
//  dangtangDemo
//
//  Created by liwei on 16/12/18.
//  Copyright © 2016年 张星星. All rights reserved.
//

import UIKit
/// 请求Url
let LWCategoryCompilationsAllDataUrl = "http://api.dantangapp.com/v1/channel_groups/all?"
// ================================================================================================================================
// MARK: 单品分类专题风格，品类的请求数据
class LWCategoryCompilationsAllData: LWServiceBase {
    /// 数据数组
    var channel_groups : [LWCategoryCompilationsAllRequestDataInfo]?
    required init() {
        
    }
}
// ================================================================================================================================
// MARK: 详细数据
class LWCategoryCompilationsAllRequestDataInfo: LWServiceBase {
    var channels : [LWCategoryCompilationsAllRequestDataInfoItem]?
    var id : Int?
    var order : Int?
    var name : String?
    var status : Int?
    required init() {
        
    }
}
// ================================================================================================================================
// MARK: 详细数据
class LWCategoryCompilationsAllRequestDataInfoItem: LWServiceBase {
    var group_id : Int?
    var icon_url : String?
    var id : Int?
    var items_count : Int?
    var name : String?
    var order : Int?
    var status : Int?
    required init() {
        
    }
}

// ================================================================================================================================
