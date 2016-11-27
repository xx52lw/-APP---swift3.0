//
//  LWNewFeatureCollectionViewCell.swift
//  dangtangDemo
//
//  Created by 张星星 on 16/11/25.
//  Copyright © 2016年 张星星. All rights reserved.
//

import UIKit
// =================================================================================================================================
// MARK: - 新特性界面cell
class LWNewFeatureCollectionViewCell: UICollectionViewCell {
  // MARK: 懒加载imageView
    lazy var imageView : UIImageView = {
        let imageV = UIImageView()
        imageV.backgroundColor = UIColor.clear
        imageV.contentMode = .scaleAspectFit
        return imageV
        
    }()
    // MARK: 懒加载进入按钮
    lazy var inputBtn : UIButton = {
        let btn = UIButton()
        let image = UIImage.getImageFromeBundleFile(fileName: "newFeature", imageName: "btn_begin")
        btn.backgroundColor = UIColor.clear
        let w = CGFloat(150.0)
        let h = CGFloat(40.0)
        let x = (LWAppScreenWidth - w) / 2;
        let y = LWAppScreenHeight - h * 2;
        btn.frame = CGRect.init(x: x, y: y, width: w, height: h)
        btn.setBackgroundImage(image, for: .normal)
        return btn
    }()
    // MARK: 重写init
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor.clear
        contentView.addSubview(imageView)
        contentView.addSubview(inputBtn)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: 重写布局
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = bounds
    }
    
}
// =================================================================================================================================
