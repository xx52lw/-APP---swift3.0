//
//  LWSelectInfoViewController.swift
//  dangtangDemo
//
//  Created by 张星星 on 16/11/26.
//  Copyright © 2016年 张星星. All rights reserved.
//

import UIKit
// =================================================================================================================================
// MARK: - 选择信息视图
class LWSelectInfoViewController: UIViewController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    override var prefersStatusBarHidden: Bool {
        return false
    }
    var isShow = true
    /// 懒加载专题提示
    lazy var remindLabel: UILabel = {
        let label = UILabel()
        label.text = "根据你的身份推荐最合适你的专题"
        label.textColor = UIColor.white
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    /// 懒加载背景图片
    lazy var bgImageView: UIImageView = {
        let bgView = UIImageView.init(frame: self.view.bounds)
        bgView.backgroundColor = UIColor.clear
        bgView.image = UIImage.getImageFromeBundleFile(fileName: "me", imageName: "Me_ProfileBackground")
        bgView.contentMode = .scaleAspectFill
        let whitView = UIView.init(frame: bgView.bounds)
        whitView.backgroundColor = UIColor.white
        whitView.alpha = 0.2
        bgView.addSubview(whitView)
        return bgView
    }()
    /// 懒加载性别选择视图
    lazy var sexView: LWSelectSexView = {
        let view = LWSelectSexView()
        view.deleagte = self
        view.alpha = 0.0
        return view
    }()
    /// 懒加载职业选择视图
    lazy var professionView: LWSelectProfessionView = {
        let view = LWSelectProfessionView()
        view.deleagte = self
        view.alpha = 0.0
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.clear
        view.addSubview(remindLabel)
        view.addSubview(bgImageView)
        self.view.addSubview(self.sexView)
        self.view.addSubview(self.professionView)
        // Do any additional setup after loading the view.
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        bgImageView.frame = view.bounds
        var x = 0.0
        var y = 0.0
        var w = view.bounds.size.width
        var h = 50.0
        remindLabel.frame = CGRect.init(x: x, y: y, width: Double(w), height: h);
        
        
        w = view.bounds.size.width * (2.0 / 3)
        h = Double(view.bounds.size.height * (3.0 / 5))
        x = Double(view.bounds.size.width - w) * 0.5
        y = (Double(view.bounds.size.height) - h) * 0.5
        sexView.frame = CGRect.init(x: 0.0, y: 0.0, width: Double(w), height: h)
        professionView.frame = sexView.frame
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.25, animations: {
        }) { (bool) in
            self.sexView.alpha = 1.0
            self.show(view: self.sexView)
            
        }
    }
}

// =================================================================================================================================
// MARK: - 选择信息视图工具类
extension LWSelectInfoViewController {
    
    func showViewAnimation(view : UIView, center : CGPoint, radius : CGFloat,startAngle : CGFloat , endAngle : CGFloat) {
        let path = CGMutablePath()
        let ani = CAKeyframeAnimation.init(keyPath: "position")
        path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        ani.path = path
        ani.duration = 0.3
        ani.isRemovedOnCompletion = false
        ani.delegate = self
        ani.fillMode = kCAFillModeForwards
        view.layer.add(ani, forKey: "pathkeyFramAnimation")
    }
    
    func show(view : UIView){
        isShow = true
        let y = LWAppScreenHeight / 2
        let r = 2 * y
        let x = -(r - LWAppScreenWidth / 2)
        showViewAnimation(view: view ,center: CGPoint.init(x: x, y: y), radius: r, startAngle: -(CGFloat)(M_PI_4), endAngle: 0)
    }
    
    func hidden(view : UIView){
        isShow = false
        let y = LWAppScreenHeight / 2
        let r = 2 * y
        let x = -(r - LWAppScreenWidth / 2)
        showViewAnimation(view: view ,center: CGPoint.init(x: x, y: y), radius: r, startAngle:0, endAngle: (CGFloat)(M_PI_4))
    }
    
}
// =================================================================================================================================
// MARK: - 动画执行的代理
extension LWSelectInfoViewController : CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if isShow == true {
            self.sexView.center = view.center
            self.professionView.center = view.center
        }
        else {
            if professionView.alpha == 1.0 {
                professionView.removeFromSuperview()
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: LWNewFeatureCompleteNotify), object: nil)
            }
            else {
                sexView.removeFromSuperview()
                professionView.alpha = 1.0
                show(view: professionView)
            }
        }
    }
}

// =================================================================================================================================
// MARK: - 选择性别和职业的代理
extension LWSelectInfoViewController : LWSelectSexViewDelegate, LWSelectProfessionViewDelegate {
    
    // 选择性别
    func selectSexView(view: LWSelectSexView, sexBtn: UIButton) {
        let info = LWUserInfoModel.sharedInstance().getUserInfo()
        info.sex = sexBtn.tag
        hidden(view: view)
    }
    // 选择职业
    func selectProfessionView(view: LWSelectProfessionView, professionBtn: UIButton) {
        let info = LWUserInfoModel.sharedInstance().getUserInfo()
        info.profession = professionBtn.tag
        LWUserInfoModel.sharedInstance().saveUserInfo(info)
        hidden(view: view)
    }
}
// =================================================================================================================================
