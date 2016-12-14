//
//  LWHomeChannelCell.swift
//  dangtangDemo
//
//  Created by liwei on 16/12/10.
//  Copyright © 2016年 张星星. All rights reserved.
//

import UIKit

class LWHomeChannelCell: UICollectionViewCell {
    // MARK: 懒加载简介标签
    lazy var nameBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor.clear
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        btn.setTitleColor(UIColor.black, for: UIControlState.normal)
        btn.setTitleColor(LWGlobalRed(), for: UIControlState.selected)
        btn.isUserInteractionEnabled = false   // 这里需要设置，cell点击有问题越过btn
        return btn
    }()
//    // MARK: 懒加载简介标签
//    lazy var nameLabel: UILabel = {
//        let label = UILabel()
//        label.backgroundColor = UIColor.clear
//        label.font = UIFont.systemFont(ofSize: 15)
//        label.textAlignment = .left
//        label.textColor = UIColor.black
//        label.numberOfLines = 2
//        return label
//    }()

    
    // MARK: 重写init方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
        contentView.addSubview(nameBtn)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

    }
    
}
