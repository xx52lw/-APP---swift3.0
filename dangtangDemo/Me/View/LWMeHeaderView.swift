//
//  LWMeHeaderView.swift
//  dangtangDemo
//
//  Created by liwei on 17/3/15.
//  Copyright © 2017年 张星星. All rights reserved.
//

import UIKit

// ===========================================================================================================================================================================
// MARK: - 我的头像信息
class LWMeHeaderView: UIView {

    /// 懒加载背景图片
    lazy var bgImageView : UIImageView = {
    let imageView = UIImageView()
        imageView.backgroundColor = UIColor.clear
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
   /// 懒加载头像信息
    lazy var headerImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.clear
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        let image = UIImage.getImageFromeBundleFile(fileName: "me", imageName: "Me_AvatarPlaceholder")
        imageView.frame = CGRect.init(origin: CGPoint.zero, size: image.size)
        imageView.layer.cornerRadius = max(image.size.width, image.size.height) * 0.5
        imageView.layer.masksToBounds = true
        return imageView
    }()
    ///懒加载昵称标签
    lazy var nickLabel : UILabel = {
        let lable = UILabel()
        lable.backgroundColor = UIColor.clear
        lable.textColor = UIColor.white
        lable.textAlignment = NSTextAlignment.center
        lable.text = "登录"
        lable.sizeToFit()
        return lable
    }()
    // 重写init
   override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(self.bgImageView)
        addSubview(self.headerImageView)
        addSubview(self.nickLabel)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // 重写layoutSubviews
    override func layoutSubviews() {
        super.layoutSubviews()
        bgImageView.frame = self.bounds
        
        var w = self.headerImageView.frame.size.width
        var h = self.headerImageView.frame.size.height
        var x = (self.frame.size.width - w) * 0.5
        var y = (self.frame.size.height - h) * 0.5
        
        self.headerImageView.frame = CGRect.init(x: x, y: y, width: w, height: h)
        
        let marign = CGFloat(10)
        w = self.frame.size.width - marign * 2
        x = marign;
        y = self.headerImageView.frame.maxY + marign
        h = self.nickLabel.frame.size.height
        self.nickLabel.frame = CGRect.init(x: x, y: y, width: w, height: h);
        
    }
}
// ===========================================================================================================================================================================
