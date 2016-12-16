//
//  LWSearchViewController.swift
//  dangtangDemo
//
//  Created by 张星星 on 16/11/25.
//  Copyright © 2016年 张星星. All rights reserved.
//

import UIKit

class LWSearchViewController: LWViewControllerBase {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

   
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        navigationController?.pushViewController(LWHomeProductDetailViewController(), animated: true)
    }
}
