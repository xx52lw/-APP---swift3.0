//
//  UIButton+Extension.swift
//  dangtangDemo
//
//  Created by 张星星 on 16/11/24.
//  Copyright © 2016年 张星星. All rights reserved.
//

import UIKit
extension UIButton {
    /// 创建正常背景大小的按钮
   class func creatButtonWithNormalBgImage(_ image : UIImage , target: Any?, action: Selector, for controlEvents: UIControlEvents) -> UIButton {
        let btn = UIButton()
        guard image.size.width > 0 else {
            return btn
        }
        btn.setBackgroundImage(image, for: UIControlState.normal)
        btn.sizeToFit()
        btn.addTarget(target, action:action, for: controlEvents)
        return btn
    }
}
