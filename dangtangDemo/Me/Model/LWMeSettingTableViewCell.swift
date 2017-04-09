//
//  LWMeSettingTableViewCell.swift
//  dangtangDemo
//
//  Created by liwei on 2017/4/9.
//  Copyright © 2017年 张星星. All rights reserved.
//

import UIKit

class LWMeSettingTableViewCell: UITableViewCell {
    // 左侧图片
    lazy var leftImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.clear
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        return imageView
    }()
    // 左侧标签
    lazy var leftLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        return label
    }()
    // 右侧图片
    lazy var rightImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.clear
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        return imageView
    }()
    // 右侧标签
    lazy var rightLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        return label
    }()
    // 右侧开关
    lazy var rightSwitch: UISwitch = {
        let switchBtn = UISwitch()
        switchBtn.isHidden = true
        return switchBtn
    }()
    // 箭头图片
    lazy var arrowImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.clear
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        return imageView
    }()
    // 下划线
    lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.clear
        self.contentView.addSubview(self.leftImageView)
        self.contentView.addSubview(self.leftLabel)
        self.contentView.addSubview(self.rightImageView)
        self.contentView.addSubview(self.rightLabel)
        self.contentView.addSubview(self.rightSwitch)
        self.contentView.addSubview(self.arrowImageView)
        self.contentView.addSubview(self.lineView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
