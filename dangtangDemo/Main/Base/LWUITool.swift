//
//  LWUITool.swift
//  dangtangDemo
//
//  Created by 张星星 on 16/11/24.
//  Copyright © 2016年 张星星. All rights reserved.
//

import UIKit
import Foundation
// ================================================================================================================================
class LWUITool : NSObject {
    
    
    /// 测量字符串Size
  class  func sizeWithStringFont(_ string : String, font : UIFont, maxSize : CGSize) -> CGSize {
       let str = string as NSString
      let option =  NSStringDrawingOptions.usesLineFragmentOrigin.rawValue | NSStringDrawingOptions.usesFontLeading.rawValue
      return str.boundingRect(with: maxSize, options: NSStringDrawingOptions(rawValue: option), attributes: [NSFontAttributeName : font], context: nil).size
    }


}
