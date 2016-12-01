//
//  LWGiftCollectionViewCell.swift
//  dangtangDemo
//
//  Created by 张星星 on 16/11/30.
//  Copyright © 2016年 张星星. All rights reserved.
//

import UIKit

class LWGiftCollectionViewCell: UICollectionViewCell {
    
    // MARK: 懒加载imageView
    lazy var imageView : UIImageView = {
        let imageV = UIImageView()
        imageV.backgroundColor = UIColor.clear
        imageV.contentMode = .scaleAspectFill
        imageV.layer.masksToBounds = true
        return imageV
        
    }()
     // MARK: 懒加载简介标签
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.numberOfLines = 2
        return label
    }()
    // MARK: 懒加载价格标签
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = LWGlobalRed()
        label.textAlignment = .left
        return label
    }()
   // MARK: 重写init方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
        addSubview(imageView)
        addSubview(nameLabel)
        addSubview(priceLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var dataInfo = LWGiftRequestDataInfo()
    
       func layoutViewSubviews() {
        super.layoutSubviews()
        var x = CGFloat(0.0)
        var y = CGFloat(0.0)
        var w = self.bounds.size.width
        var h = self.bounds.size.width
        imageView.frame = CGRect.init(x: x, y: y, width: w, height: h)
        LWImageTool.imageUrlAndPlaceImage(imageView: imageView, stringUrl: dataInfo.cover_image_url, placeholdImage: LWGlobalPlaceHolderImage)
        y = imageView.frame.maxY
//        h = LWUITool.sizeWithStringFont(dataInfo.name!, font: UIFont.systemFont(ofSize: 15), maxSize: CGSize.init(width: w, height: w)).height + 10
        h = 40
        x = 5.0
        w = w - 5.0 * 2
        nameLabel.frame = CGRect.init(x: x, y: y, width: w, height: h)
        nameLabel.text = dataInfo.name
        y = nameLabel.frame.maxY
        let priceStr = dataInfo.price! as String
//        h = LWUITool.sizeWithStringFont(priceStr, font: UIFont.systemFont(ofSize: 13), maxSize: CGSize.init(width: w, height: w)).height + 10
        h = 20
        priceLabel.frame = CGRect.init(x: x, y: y, width: w, height: h)
        priceLabel.text = "￥\(priceStr)"
        
    }
}
