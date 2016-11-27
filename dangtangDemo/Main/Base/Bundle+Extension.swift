//
//  Bundle+Extension.swift
//  dangtangDemo
//
//  Created by 张星星 on 16/11/22.
//  Copyright © 2016年 张星星. All rights reserved.
//

import Foundation

extension Bundle {
    // 计算性属性类似函数，没有参数，有返回值
    /// 获取当前的bundleName
    var nameSpace : String {
        return (infoDictionary?["CFBundleName"] as? String) ?? ""
    }
    var version : String {
        return (infoDictionary?["CFBundleShortVersionString"] as? String) ?? ""    
    }
}
