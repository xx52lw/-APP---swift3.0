//
//  LWWebView.swift
//  dangtangDemo
//
//  Created by liwei on 16/12/16.
//  Copyright © 2016年 张星星. All rights reserved.
//

import UIKit

class LWWebView: UIWebView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        layer.isOpaque = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
