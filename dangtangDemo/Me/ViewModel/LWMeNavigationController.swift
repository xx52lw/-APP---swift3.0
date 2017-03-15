//
//  LWMeNavigationController.swift
//  dangtangDemo
//
//  Created by 张星星 on 16/11/22.
//  Copyright © 2016年 张星星. All rights reserved.
//

import UIKit

class LWMeNavigationController: LWNavigationControllerBase {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置背景颜色为透明色
//        let image = UIImage.drawImageWithColor(color: UIColor.clear, size: CGSize.init(width: 1, height: 1))
//        self.navigationBar.setBackgroundImage(image, for: UIBarMetrics.default)
//        self.navigationBar.shadowImage = image // 去除下划线
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
