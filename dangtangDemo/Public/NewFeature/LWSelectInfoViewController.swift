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
        view.alpha = 0.0
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.clear
        view.addSubview(bgImageView)
        self.view.addSubview(self.sexView)
       
        // Do any additional setup after loading the view.
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        bgImageView.frame = view.bounds
        let w = view.bounds.size.width * (2.0 / 3)
        let h = view.bounds.size.height * (2.0 / 3)
        sexView.frame = CGRect.init(x: 0, y: 0, width: w, height: h)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.5, animations: {
        }) { (bool) in
            self.sexView.alpha = 1.0
            self.pathkeyFramAnimation(view: self.sexView)
            
        }
    }
}

/*
 - (void)pathKeyframeAni {
 CAKeyframeAnimation * ani = [CAKeyframeAnimation animationWithKeyPath:@"position"];
 CGMutablePathRef path = CGPathCreateMutable();
 //    CGPathAddEllipseInRect(path, NULL, CGRectMake(130, 200, 100, 100));
 CGFloat y = [UIScreen mainScreen].bounds.size.height * 0.5;
 CGFloat r = pow(2, 0.5) * y;
 CGFloat x = -(r - [UIScreen mainScreen].bounds.size.width * 0.5);
 CGPathAddArc(path, NULL, x, y, r, -M_PI_4, 0, 0);
 ani.path = path;
 CGPathRelease(path);
 ani.duration = 5;
 ani.removedOnCompletion = NO;
 ani.fillMode = kCAFillModeForwards;
 [self.myView.layer addAnimation:ani forKey:@"PostionKeyframePathAni"];
 }
 
 - (void) al {
 self.myView.alpha = 0;
 [UIView animateWithDuration:5 animations:^{
 self.myView.alpha = 1;
 }];
 }

 */

// =================================================================================================================================
// MARK: - 选择信息视图工具类
extension LWSelectInfoViewController {
    
    func pathkeyFramAnimation(view : UIView) {
        let path = CGMutablePath()
        let y = LWAppScreenHeight / 2
        let r = pow(2.0, 0.5) * y
        let x = -(r - LWAppScreenWidth / 2)
        
        let ani = CAKeyframeAnimation.init(keyPath: "position")
        path.addArc(center: CGPoint.init(x: x, y: y), radius: r, startAngle: -(CGFloat)(M_PI_4), endAngle: 0, clockwise: false)
        ani.path = path
        ani.duration = 0.5
        ani.isRemovedOnCompletion = false
        ani.delegate = self
        ani.fillMode = kCAFillModeForwards
        view.layer.add(ani, forKey: "pathkeyFramAnimation")
        
    }
    
}

extension LWSelectInfoViewController : CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        self.sexView.center = view.center
    }
}

// =================================================================================================================================
// MARK: - 选择性别视图
class LWSelectSexView : UIView {
    lazy var boyBtn: UIButton = {
        let btn = UIButton.creatButtonWithNormalBgImage(UIImage.getImageFromeBundleFile(fileName: "newFeature", imageName: "newFeature_boy"), target: self, action: #selector(btnClick), for: .touchUpInside);
        btn.tag = 1
        return btn
    }()
    func btnClick(btn : UIButton){
        print("tag = \(btn.tag)")
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.boyBtn)
        self.backgroundColor = UIColor.red
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// =================================================================================================================================
// MARK: - 选择职业视图
class LWSelectProfessionView : UIView {
    
}
// =================================================================================================================================
