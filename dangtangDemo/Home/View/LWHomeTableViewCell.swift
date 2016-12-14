//
//  LWHomeTableViewCell.swift
//  dangtangDemo
//
//  Created by liwei on 16/12/10.
//  Copyright © 2016年 张星星. All rights reserved.
//

import UIKit

class LWHomeTableViewCell: UITableViewCell {

  // MARK: 图片
    lazy var coverImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = UIViewContentMode.scaleToFill
        view.clipsToBounds = true
        view.backgroundColor = UIColor.clear
        return view
    }()
  //MARK: 收藏按钮
    lazy var collectBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor.clear
//        btn.titleLabel?.font = UIFont.systemFont(ofSize: 8)
        btn.setTitleColor(UIColor.white, for: UIControlState.normal)
        btn.setTitleColor(LWGlobalRed(), for: UIControlState.selected)
//        btn.isUserInteractionEnabled = false   // 这里需要设置，否侧cell点击有问题
        return btn
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
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(coverImageView)
        contentView.addSubview(collectBtn)
        contentView.addSubview(titleLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: 创建cell
    class func createCell(tableView: UITableView, identifier: String) -> LWHomeTableViewCell{
        var cell : LWHomeTableViewCell? = tableView.dequeueReusableCell(withIdentifier: identifier) as! LWHomeTableViewCell?
        if cell == nil {
            cell = LWHomeTableViewCell.init(style: .default, reuseIdentifier: identifier)
        }
        return cell!
    }
    
}
