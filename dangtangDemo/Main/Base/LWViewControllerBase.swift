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
        
//        if (self.navigationController?.viewControllers.count)! > 1 {
        
            let bgBtnImage = UIImage.getImageFromeBundleFile(fileName: "nav", imageName: "Nav_backward")
            self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: UIButton.creatButtonWithNormalBgImage(bgBtnImage, target: self, action: #selector(backClick), for: UIControlEvents.touchUpInside))
        
//        }
        // Do any additional setup after loading the view.
    }

    /// 返回按钮点击
    func backClick(){
        navigationController?.popViewController(animated: true)
    }
    
}
