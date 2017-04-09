//
//  LWMeSettingDrawModel.swift
//  dangtangDemo
//
//  Created by liwei on 2017/4/9.
//  Copyright © 2017年 张星星. All rights reserved.
//

import UIKit
// =================================================================================================================================
// MARK: - 我的设置绘制模型
class LWMeSettingDrawModel: NSObject {

    /// 绘制设置
    func drawSetting(tableView: UITableView, cell: LWMeSettingTableViewCell, model: LWMeSettingGroupCellModel){
        
        let margin = CGFloat(10.0)
        let maxWidth = cell.frame.size.width
        let maxHeight = CGFloat(44.0)
        var x = margin
        var y = margin
        var w = maxWidth
        var h = maxHeight
        let font = UIFont.systemFont(ofSize: 15.0)
        // 左侧图片
        let leftImage = UIImage.getImageFromeBundleFile(fileName: "me", imageName: model.iconImage)
        
        h = maxHeight - margin * 2
        if leftImage.size.height > 0 {
            w = (leftImage.size.width / leftImage.size.height) * h
        }
        else {
            w = 0.0
        }
        cell.leftImageView.frame = CGRect.init(x: x, y: y, width: w, height: h)
        cell.leftImageView.image = leftImage
        // 显示箭头
        if model.isHiddenArrow == false {
           let arrowImage = UIImage.getImageFromeBundleFile(fileName: "comment", imageName: "cellArrow")
           w = arrowImage.size.width
           h = min(arrowImage.size.height, maxHeight)
           y = (maxHeight - h) * 0.5
           x = maxWidth - w - margin
           cell.arrowImageView.frame = CGRect.init(x: x, y: y, width: w, height: h)
           cell.arrowImageView.image = arrowImage
        }
        else {
            cell.arrowImageView.frame = CGRect.zero
        }
        // 左侧标签
        x = cell.leftImageView.frame.maxX + margin
        w = maxWidth * 0.5 - x
        let leftLabelSize = LWUITool.sizeWithStringFont(model.leftTitle, font: font, maxSize: CGSize.init(width: w, height: maxHeight))
        w = leftLabelSize.width
        h = leftLabelSize.height
        y = (maxHeight - h) * 0.5
        cell.leftLabel.frame = CGRect.init(x: x, y: y, width: w, height: h)
        cell.leftLabel.font = font
        cell.leftLabel.text = model.leftTitle
        // 下划线
        x = cell.leftImageView.frame.maxX
        h = 1.0
        w = maxWidth - x
        y = maxHeight - h
        cell.lineView.frame = CGRect.init(x: x, y: y, width: w, height: h)
        cell.lineView.backgroundColor = LWGlobalViewBgColor()
        
    }
    
}
// =================================================================================================================================
