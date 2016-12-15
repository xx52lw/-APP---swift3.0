//
//  LWViewControllerBase.swift
//  dangtangDemo
//
//  Created by 张星星 on 16/11/22.
//  Copyright © 2016年 张星星. All rights reserved.
//

import UIKit

class LWViewControllerBase: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = LWGlobalViewBgColor()
        // 使其从导航条下绘制
        navigationController?.navigationBar.isTranslucent = false
        self.edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)
        self.automaticallyAdjustsScrollViewInsets = false;
        
        addNotifty()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name:NSNotification.Name(rawValue: "lwBeignbackClick"), object: nil)
        NotificationCenter.default.removeObserver(self, name:NSNotification.Name(rawValue: "lwBeignDrugViewController"), object: nil)
    }
    
    private func addNotifty() {
        NotificationCenter.default.removeObserver(self, name:NSNotification.Name(rawValue: "lwBeignbackClick"), object: nil)
        NotificationCenter.default.removeObserver(self, name:NSNotification.Name(rawValue: "lwBeignDrugViewController"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(backClick), name: NSNotification.Name(rawValue: "lwBeignbackClick"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(beginDrug), name: NSNotification.Name(rawValue: "lwBeignDrugViewController"), object: nil)
        
    }
    
    /// 返回按钮点击
    func backClick(){
        self.navigationController?.popViewController(animated: true)
    }
    /// 开始侧滑拖拽
    func beginDrug()  {
        
    }
}
