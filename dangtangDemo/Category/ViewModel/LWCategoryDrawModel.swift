//
//  LWCategoryDrawModel.swift
//  dangtangDemo
//
//  Created by liwei on 16/12/18.
//  Copyright © 2016年 张星星. All rights reserved.
//

import UIKit

class LWCategoryDrawModel: NSObject {
    /// 绘制简介cell
    class func drawHomeCell(tableView: UITableView, cell: LWCategoryListsViewCellTableViewCell, info: LWCategoryCompilationsListsRequestDataInfo) {
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.backgroundColor = UIColor.clear
        var y : CGFloat = 0
        var x : CGFloat = 0
        var w : CGFloat = tableView.frame.size.width
        var h : CGFloat = (tableView.frame.size.width * LWHomeCellHeightWidth)
        cell.coverImageView.frame = CGRect.init(x: 5, y: 5, width: w - 10, height: h - 5)
        LWImageTool.imageUrlAndPlaceImage(imageView: (cell.coverImageView), stringUrl: info.cover_image_url, placeholdImage: LWGlobalPlaceHolderImage)
        cell.coverImageView.layer.cornerRadius = 5.0
        cell.coverImageView.layer.masksToBounds = true
        let image = UIImage.getImageFromeBundleFile(fileName: "comment", imageName: "likeCount")
        let likeCount = (NSString.init(format: "%ld", info.likes_count!) as String)
        let likeSize = LWUITool.sizeWithStringFont(likeCount, font: UIFont.boldSystemFont(ofSize: 10.0), maxSize: CGSize.init(width: cell.coverImageView.frame.size.width, height: 200))
        w = image.size.width + likeSize.width + 10
        y = cell.coverImageView.frame.minY + 5.0
        x = cell.coverImageView.frame.maxX - w - y
        h = likeSize.height + 10
        
        cell.collectBtn.frame = CGRect.init(x: x, y: y, width: w, height: h)
        cell.collectBtn.backgroundColor = UIColor.gray
        cell.collectBtn.setTitle(likeCount, for: .normal)
        cell.collectBtn.setImage(image, for: .normal)
        cell.collectBtn.alpha = 0.8
        cell.collectBtn.layer.cornerRadius = h * 0.5
        cell.collectBtn.layer.masksToBounds = true
        cell.collectBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 10)
        
        let title = info.title!
        let titleSize = LWUITool.sizeWithStringFont(title, font: UIFont.systemFont(ofSize: 17.0), maxSize: CGSize.init(width: cell.coverImageView.frame.size.width, height: 200))
        x = cell.coverImageView.frame.minX + 5.0
        h = titleSize.height
        w = cell.coverImageView.frame.width
        y = cell.coverImageView.frame.maxY - h - 5.0
        cell.titleLabel.frame = CGRect.init(x: x, y: y, width: w, height: h)
        cell.titleLabel.text = title
        cell.titleLabel.font = UIFont.systemFont(ofSize: 17.0)
    }

}
