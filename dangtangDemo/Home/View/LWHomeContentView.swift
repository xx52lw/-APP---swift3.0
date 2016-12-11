//
//  LWHomeContentView.swift
//  dangtangDemo
//
//  Created by liwei on 16/12/10.
//  Copyright © 2016年 张星星. All rights reserved.
//

import UIKit

class LWHomeContentView: UIView {

    // MARK: 懒加载内容View
    lazy var contenView: LWHomeBannerTableView = {
        let view = LWHomeBannerTableView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(contenView)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contenView.frame = self.bounds
        

    }

    
    
}
