//
//  LWHomeChannelData.swift
//  dangtangDemo
//
//  Created by liwei on 16/12/10.
//  Copyright © 2016年 张星星. All rights reserved.
//

import UIKit
/// 请求Url
let LWHomeChannelDataUrl = "http://api.dantangapp.com/v2/channels/preset?"
// ================================================================================================================================
// MARK: 单品首页频道请求数据
class LWHomeChannelData: LWServiceBase {
    /// 性别
    var gender : Int?
    var generation : Int?
    
    required init() {
        
    }

}
// ================================================================================================================================
// MARK: 单品首页数据的响应数据
class LWHomeChannelRequestData: LWServiceBase {
    /// 数据数组
    var channels : [LWHomeChannelRequestInfo]?
    required init() {
        
    }
}
// ================================================================================================================================
// MARK: 详细数据
class LWHomeChannelRequestInfo: LWServiceBase {
    var itemSize : CGSize?
    var editable : Bool?
    var id : Int?
    var name : String?
    required init() {
        
    }
}
