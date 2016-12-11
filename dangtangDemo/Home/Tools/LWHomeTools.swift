//
//  LWHomeTools.swift
//  dangtangDemo
//
//  Created by liwei on 16/12/10.
//  Copyright © 2016年 张星星. All rights reserved.
//

import UIKit

class LWHomeTools: NSObject {

    /// 测量频道item的Size
    class func sizeChannelItem(title: String, font: UIFont) -> CGSize {
        let size = LWUITool.sizeWithStringFont(title, font: font, maxSize: CGSize.init(width: 200, height: 200))
        return CGSize.init(width: size.width + 20, height: size.height + 10)
    }
    
}
