//
//  LWImageTool.swift
//  dangtangDemo
//
//  Created by 张星星 on 16/11/30.
//  Copyright © 2016年 张星星. All rights reserved.
//

import UIKit
import Kingfisher
class LWImageTool: NSObject {

    ///  对Kingfisher的再次封装
    class func imageUrlAndPlaceImage(imageView : UIImageView , stringUrl : String? , placeholdImage : UIImage) {
        var urlString = stringUrl
        if  urlString == nil {
            urlString = ""
        }
        let url = URL(string : urlString!)
        imageView.kf.setImage(with: url, placeholder: placeholdImage, options: nil, progressBlock: nil, completionHandler: nil)
    }
    
}
