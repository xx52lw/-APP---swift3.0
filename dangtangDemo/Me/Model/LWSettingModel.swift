//
//  LWSettingModel.swift
//  dangtangDemo
//
//  Created by liwei on 17/3/16.
//  Copyright © 2017年 张星星. All rights reserved.
//

import UIKit

class LWSettingModel: LWServiceBase {
    /// 数据数组
    var items : [LWSettingGroupModel]?
    
    required init() {
        
    }
}

class LWSettingGroupModel: LWServiceBase {
    /// 数据数组
    var cells : [LWSettingGroupCellModel]?
    
    required init() {
        
    }
}

class LWSettingGroupCellModel: LWServiceBase {
    /// 
    var iconImage : String = ""
    var leftTitle : String = ""
    var rightTitle : String = ""
    var isHiddenSwitch : Bool = true
    var isHiddenRightTip : Bool = true
    
    required init() {
        
    }
}
