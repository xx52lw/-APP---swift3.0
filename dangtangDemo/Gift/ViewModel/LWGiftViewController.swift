//
//  LWGiftViewController.swift
//  dangtangDemo
//
//  Created by 张星星 on 16/11/22.
//  Copyright © 2016年 张星星. All rights reserved.
//

import UIKit

class LWGiftViewController: LWViewControllerBase {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = nil
        // Do any additional setup after loading the view.
        
        let giftData = LWGiftData()
        let info = LWUserInfoModel.sharedInstance().getUserInfo()
        
        giftData.gender = info.sex
        giftData.generation = 1
        giftData.limit = 2
        giftData.offset = 0
        let dict = LWNetWorkingTool<LWGiftData>.getDictinoary(model: giftData)
    
        LWNetWorkingTool<LWGiftRequestData>.getDataFromeServiceRequest(url: LWGiftDataUrl, params: dict , successBlock:
            { jsonModel in
           
                    print("first: \(jsonModel)")
                
                    }) { (error) in
                
                    }
        
    }

}
