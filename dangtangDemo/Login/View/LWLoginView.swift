//
//  LWLoginView.swift
//  dangtangDemo
//
//  Created by 张星星 on 17/3/14.
//  Copyright © 2017年 张星星. All rights reserved.
//

import UIKit
protocol LWLoginViewDelegate : NSObjectProtocol {
    /// 点击注册界面按钮
    func loginView(view: LWLoginView, index: Int)
}
// ===================================================================================================================================
// MARK: - 登录视图
class LWLoginView: UIView {
    /// 设置代理
    weak var delegate : LWLoginViewDelegate?
    // // MARK: 懒加载输入框上分割线
    lazy var inputTopLine: UIView = {
        let view = self.createLineView()
        return view
    }()
    // MARK: 懒加载手机号输入框
    lazy var phoneTextField : UITextField = {
        let textField = UITextField()
        let font = UIFont.systemFont(ofSize: 15)
        let size = LWUITool.sizeWithStringFont("手机号", font: font, maxSize: CGSize.init(width: 200, height: 200))
        textField.backgroundColor = UIColor.white
        textField.font = font
        textField.keyboardType = UIKeyboardType.phonePad
        textField.placeholder = "手机号"
        textField.frame = CGRect.init(origin: CGPoint.zero, size: size)
        textField.leftView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 20, height: size.height))
        textField.leftViewMode = UITextFieldViewMode.always
        return textField
    }()
    // // MARK: 懒加载输入框中间分割线
    lazy var inputMinLine: UIView = {
        let view = self.createLineView()
        return view
    }()
   // // MARK: 懒加载密码输入框
    lazy var pwdTextField : UITextField = {
        let textField = UITextField()
        let font = UIFont.systemFont(ofSize: 15)
        let size = LWUITool.sizeWithStringFont("密码", font: font, maxSize: CGSize.init(width: 200, height: 200))
        textField.backgroundColor = UIColor.white
        textField.font = font
        textField.isSecureTextEntry = true
        textField.returnKeyType = UIReturnKeyType.go
        textField.placeholder = "密码"
        textField.frame = CGRect.init(origin: CGPoint.zero, size: size)
        textField.leftView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 20, height: size.height))
        textField.leftViewMode = UITextFieldViewMode.always
        return textField
    }()
    // // MARK: 懒加载输入框底部分割线
    lazy var inputBottomLine: UIView = {
        let view = self.createLineView()
        return view
    }()
    // // MARK: 懒加载登录按钮
    lazy var loginBtn : UIButton = {
        let btn = UIButton()
        let text = "登录"
        btn.setTitle(text, for: UIControlState.normal)
        btn.tag = 1
        btn.backgroundColor = LWGlobalRed()
        btn.layer.cornerRadius = 5.0
        btn.layer.masksToBounds = true
        return btn
    }()
    // // MARK: 懒加载遮盖按钮
    lazy var coverLoginBtnView: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 1, height: 1))
        view.backgroundColor = UIColor.white
        view.alpha = 0.5
        return view
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
        addSubview(self.phoneTextField)
        addSubview(self.pwdTextField)
        addSubview(self.inputTopLine)
        addSubview(self.inputMinLine)
        addSubview(self.inputBottomLine)
        addSubview(self.loginBtn)
        addSubview(self.coverLoginBtnView)
        self.coverLoginBtnView.isHidden = false
        self.loginBtn.addTarget(self, action: #selector(clickBtn), for: UIControlEvents.touchUpInside)
        NotificationCenter.default.addObserver(self, selector: #selector(inputTextFieldNotify), name: NSNotification.Name.UITextFieldTextDidChange, object: self.phoneTextField)
        NotificationCenter.default.addObserver(self, selector: #selector(inputTextFieldNotify), name: NSNotification.Name.UITextFieldTextDidChange, object: self.pwdTextField)
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // // MARK: 布局界面
    override func layoutSubviews() {
        super.layoutSubviews()
        let margin : CGFloat = 10.0
        var y = margin * 4
        var x : CGFloat = 0.0
        var w = self.bounds.size.width
        var h = self.phoneTextField.frame.size.height + margin
        self.inputTopLine.frame = CGRect.init(x: x, y: y, width: w, height: 1.0)
        self.phoneTextField.frame = CGRect.init(x: x, y: y, width: w, height: h)
        y = self.phoneTextField.frame.maxY
        self.pwdTextField.frame = CGRect.init(x: x, y: y, width: w, height: h)
        
        self.inputMinLine.frame = CGRect.init(x: x + (self.phoneTextField.leftView?.frame.size.width)!, y: y, width: w, height: 1.0)
        y = self.pwdTextField.frame.maxY
        self.inputBottomLine.frame = CGRect.init(x: x, y: y, width: w, height: 1.0)
        
        x = self.inputMinLine.frame.minX
        y = self.inputBottomLine.frame.maxY + margin * 4
        w = self.bounds.size.width - x * 2
        h = self.phoneTextField.frame.size.height
        self.loginBtn.frame = CGRect.init(x: x, y: y, width: w, height: h)
        self.coverLoginBtnView.frame = self.loginBtn.frame
    }
    
    
    // // MARK: 点击按钮
    func clickBtn(btn : UIButton) {
        delegate?.loginView(view: self, index: btn.tag)
    }
    
}
// ===================================================================================================================================
extension LWLoginView {
    // // MARK: 创建分割线
    func createLineView() -> UIView {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 1, height: 1))
        view.backgroundColor = UIColor.gray
        view.alpha = 0.5
        return view
    }

    //// MARK: 输入框输入通知
    func inputTextFieldNotify() {
        if ((self.phoneTextField.text?.characters.count)! > 0 && (self.pwdTextField.text?.characters.count)! > 0) {
            self.coverLoginBtnView.isHidden = true
        }
        else {
            self.coverLoginBtnView.isHidden = false
        }
    }
    
}
// ===================================================================================================================================
