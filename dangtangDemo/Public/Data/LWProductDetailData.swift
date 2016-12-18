//
//  LWProductDetailData.swift
//  dangtangDemo
//
//  Created by liwei on 16/12/18.
//  Copyright © 2016年 张星星. All rights reserved.
//

import UIKit
/// 请求Urlhttp://api.dantangapp.com/v1/posts/258?
let LWProductDetailDataUrl = "http://api.dantangapp.com/v1/posts/"
// ================================================================================================================================
// MARK: 单品产品详情的请求参数
class LWProductDetailData: LWServiceBase {
    var comments_count : Int?
    var content_html : String?
    var content_url : String?
    var cover_image_url : String?
    var created_at : Int?
    var id : Int?
    var liked : Bool?
    var likes_count : Int?
    var published_at : Int?
    var share_msg : String?
    var shares_count : Int?
    var short_title : String?
    var status : Int?
    var title : String?
    var type : String?
    var updated_at : Int?
    var url : String?
    
    required init() {
        
    }
    
}
