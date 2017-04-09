//
//  WCMeSettingModel.swift
//  dangtangDemo
//
//  Created by liwei on 2017/4/9.
//  Copyright © 2017年 张星星. All rights reserved.
//

import UIKit
// =================================================================================================================================
// MARK: - 我的设置cell模型
class LWMeSettingGroupCellModel: LWServiceBase {
 
    var iconImage : String = ""
    var leftTitle : String = ""
    var rightTitle : String = ""
    var isHiddenSwitch   : Bool = false
    var isHiddenRightTip : Bool = false
    var isHiddenArrow : Bool = false
    required init() {
        
    }
}

class LWMeSettingGroupModel: LWServiceBase {
    /// 数据数组
    var cells = NSArray()
    required init() {
        
    }
}

class LWMeSettingModel: LWServiceBase {
    /// 数据数组
    var groups : [LWMeSettingGroupModel]?
    required init() {
        
    }
}

// =================================================================================================================================
