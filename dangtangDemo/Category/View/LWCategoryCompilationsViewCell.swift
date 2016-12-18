//
//  LWCategoryCompilationsViewCell.swift
//  dangtangDemo
//
//  Created by liwei on 16/12/18.
//  Copyright © 2016年 张星星. All rights reserved.
//

import UIKit

class LWCategoryCompilationsViewCell: UICollectionViewCell {
    // MARK: 图片
    lazy var coverImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = UIViewContentMode.scaleToFill
        view.clipsToBounds = true
        view.backgroundColor = UIColor.clear
        return view
    }()
    // MARK: 标题标签
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.textAlignment = .left
        label.backgroundColor = UIColor.clear
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    // MARK: 重写init方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(coverImageView)
        contentView.addSubview(titleLabel)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
