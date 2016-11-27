//
//  UIImage+Extension.swift
//  dangtangDemo
//
//  Created by 张星星 on 16/11/22.
//  Copyright © 2016年 张星星. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    /// 从bundle文件夹里面获取图片
    class func getImageFromeBundleFile(fileName : String, imageName : String) -> UIImage {
        let name = fileName + "/" + imageName
        return getImageFromBundle(imageName: name)
    }
    
    
    
    /// 从bundle获取图片
    class func getImageFromBundle(imageName: String) -> UIImage {
        let scale = NSInteger(UIScreen.main.scale)
        var name = "imageResources.bundle/\(imageName)@\(scale)x.png"
        var path = Bundle.main.path(forResource: name, ofType: nil)
        if path == nil {
            name = "imageResources.bundle/\(imageName)@2x.png"
            path = Bundle.main.path(forResource: name, ofType: nil)
            if path == nil {
                name = "imageResources.bundle/\(imageName).png"
                path = Bundle.main.path(forResource: name, ofType: nil)
                if path == nil {
                    name = "imageResources.bundle"
                    path = Bundle.main.path(forResource: name, ofType: nil)
                }
            }
        }
        let image = UIImage(contentsOfFile : path!)
        if (image != nil)  {
           return image!
        }
        return UIImage()
    }
    ///  根据图片,返回一个拉伸后的图片
    class func stretchableImageName(imageName: String) -> UIImage {
        let image = UIImage(named: imageName)!
        let width = NSInteger(image.size.width * 0.5)
        let height = NSInteger(image.size.height * 0.5)
        return image.stretchableImage(withLeftCapWidth: width, topCapHeight: height)
    }
   /// 获取颜色图片
    class func drawImageWithColor(color : UIColor, size : CGSize) -> UIImage? {
        let rect = CGRect.init(x: 0.0, y: 0.0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return colorImage
        
    }
    
}
