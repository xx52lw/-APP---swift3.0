//
//  LWSelectProfessionView.swift
//  dangtangDemo
//
//  Created by 张星星 on 16/11/27.
//  Copyright © 2016年 张星星. All rights reserved.
//

import UIKit


// =================================================================================================================================
// MARK: - 选择性别视图代理
protocol LWSelectProfessionViewDelegate : NSObjectProtocol {
    func selectProfessionView(view : LWSelectProfessionView,professionBtn : UIButton)
}
// MARK: - 选择性别视图
class LWSelectProfessionView : UIView {
    // ?可选 ！必须实现
    weak var  deleagte : LWSelectProfessionViewDelegate?
    
    /// 懒加载专题提示
    lazy var remindLabel: UILabel = {
        let label = UILabel()
        label.text = "请选择您的性别"
        label.textColor = UIColor.gray
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray
        view.alpha = 0.5
        return view
    }()
    lazy var boyBtn: UIButton = {
        let btn = UIButton.creatButtonWithNormalBgImage(UIImage.getImageFromeBundleFile(fileName: "newFeature", imageName: "newFeature_boy"), target: self, action: #selector(btnClick), for: .touchUpInside);
        btn.tag = 1
        btn.adjustsImageWhenHighlighted = false
        return btn
    }()
    lazy var boyLabel: UILabel = {
        let label = UILabel()
        label.text = "牛逼"
        label.textColor = UIColor.black
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    lazy var girlBtn: UIButton = {
        let btn = UIButton.creatButtonWithNormalBgImage(UIImage.getImageFromeBundleFile(fileName: "newFeature", imageName: "newFeature_girl"), target: self, action: #selector(btnClick), for: .touchUpInside);
        btn.tag = 2
        btn.adjustsImageWhenHighlighted = false
        return btn
    }()
    lazy var girlLabel: UILabel = {
        let label = UILabel()
        label.text = "学生"
        label.textColor = UIColor.black
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    func btnClick(btn : UIButton){
        deleagte?.selectProfessionView(view: self, professionBtn: btn)
        print("tag = \(btn.tag)")
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.addSubview(self.remindLabel)
        self.addSubview(self.lineView)
        self.addSubview(self.boyBtn)
        self.addSubview(self.boyLabel)
        self.addSubview(self.girlBtn)
        self.addSubview(self.girlLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        var x = 0.0
        var y = 0.0
        var w = self.bounds.size.width
        var h = 50.0
        
        self.remindLabel.frame = CGRect.init(x: x, y: y, width: Double(w), height: h)
        y = Double(self.remindLabel.frame.maxY)
        h = 1.0
        self.lineView.frame = CGRect.init(x: x, y: y, width: Double(w), height: h)
        
        w = boyBtn.frame.size.width
        let margin = Double((self.bounds.size.width - w * 2)) / 4.0
        x = margin
        y = Double(self.center.y - w * 0.5)
        self.boyBtn.frame = CGRect.init(x: x, y: y, width: Double(w), height: Double(w))
        x = Double(self.bounds.size.width - w) - margin
        self.girlBtn.frame = CGRect.init(x: x, y: y, width: Double(w), height: Double(w))
        
        h = 50.0
        y = Double(self.boyBtn.frame.maxY)
        x = Double(self.boyBtn.frame.minX)
        self.boyLabel.frame = CGRect.init(x: x, y: y, width: Double(w), height: h)
        x = Double(self.girlBtn.frame.minX)
        self.girlLabel.frame = CGRect.init(x: x, y: y, width: Double(w), height: h)
    }
    
}

// =================================================================================================================================
