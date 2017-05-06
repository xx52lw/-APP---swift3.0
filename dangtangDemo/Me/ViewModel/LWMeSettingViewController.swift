//
//  LWMeSettingViewController.swift
//  dangtangDemo
//
//  Created by liwei on 17/3/16.
//  Copyright © 2017年 张星星. All rights reserved.
//

import UIKit
// =================================================================================================================================
// MARK: - 我的设置视图控制器
class LWMeSettingViewController: LWViewControllerBase {

    //MARK: 懒加载设置数组
    lazy var settingArray : NSArray = {
        guard let path = Bundle.main.path(forResource: "settingConfiguration", ofType: ".plist") else {
            return NSArray.init()
        }
        let settingArray = NSArray.init(contentsOfFile: path)
        guard let arrayCount = settingArray?.count else {
            return NSArray.init()
        }
        let tempArray = NSMutableArray.init()
        for index in 0..<arrayCount {
            let group = LWMeSettingGroupModel()
            let groupArray = settingArray?.object(at: index) as! NSArray
            let groupTemp = NSMutableArray.init()
            if groupArray.count > 0 {
                for item in 0..<groupArray.count {
                    let dic = groupArray.object(at: item) as! Dictionary<String, Any>
                    let cellModel = LWMeSettingGroupCellModel()
                    cellModel.iconImage = dic["iconImage"] as! String
                    cellModel.isHiddenSwitch = dic["isHiddenSwitch"] as? Bool
                    cellModel.isHiddenRightTip = dic["isHiddenRightTip"] as? Bool
                    cellModel.isHiddenArrow = dic["isHiddenArrow"] as? Bool
                    cellModel.leftTitle = dic["leftTitle"] as! String
                    cellModel.rightTitle = dic["rightTitle"] as! String
                    groupTemp.add(cellModel)
                }
            }
            group.cells = groupTemp  as NSArray
            tempArray.add(group);
        }
        return tempArray
    }()

    //MARK: 懒加载列表数组
    lazy var tableView : UITableView = {
        let view = UITableView.init(frame: CGRect.init(), style: UITableViewStyle.grouped)
        view.separatorStyle = UITableViewCellSeparatorStyle.none
        view.delegate = self
        view.dataSource = self
        return view
    }()
    //MARK: 懒加载绘制模型
    lazy var drawModel: LWMeSettingDrawModel = {
        let model = LWMeSettingDrawModel()
        return model
    }()
    
    //MARK: 重写viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "设置"
        for index in 0..<self.settingArray.count {
            if index == 0 {
                let group = self.settingArray.object(at: index) as! LWMeSettingGroupModel
                for i in 0..<group.cells.count {
                 let cellModel = group.cells.object(at: i) as! LWMeSettingGroupCellModel
                    if i == 1 {
                        cellModel.rightTitle = "☺️"
                    }
                }
            }
            if index == 1 {
                let group = self.settingArray.object(at: index) as! LWMeSettingGroupModel
                for i in 0..<group.cells.count {
                    let cellModel = group.cells.object(at: i) as! LWMeSettingGroupCellModel
                    if i == 0 {
                        let info = LWUserInfoModel.sharedInstance().getUserInfo()
                        var rightString = ""
                        if info.sex == 1 {
                            rightString = "男孩"
                        }
                        else {
                           rightString = "女孩"
                        }
                        rightString = rightString + " "
                        if info.profession == 1 {
                            rightString = rightString + "牛逼"
                        }
                        else if info.profession == 2  {
                            rightString = rightString + "学生"
                        }
                        cellModel.rightTitle = rightString
                    }
                }
            }
        }
        self.view.addSubview(self.tableView)
    }
    //MARK: 重写viewWillLayoutSubviews
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.tableView.frame = self.view.frame
    }
}
// =================================================================================================================================
// MARK: - 我的设置视图控制器
extension LWMeSettingViewController : UITableViewDelegate,UITableViewDataSource {
    //MARK: 返回组数
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.settingArray.count
    }
    //MARK: 每组cell数量
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section < self.settingArray.count {
            guard let groupModel : LWMeSettingGroupModel = self.settingArray.object(at: section) as? LWMeSettingGroupModel else {
                return 0
            }
          return (groupModel.cells.count)
        }
        return 0
    }
    //MARK: 每组的高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    //MARK: cell 的样式
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ID = "LWMeSettingTableViewCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: ID)
        if cell == nil {
            cell = LWMeSettingTableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: ID)
            cell?.backgroundColor = UIColor.white
        }
        guard let groupModel : LWMeSettingGroupModel = self.settingArray.object(at: indexPath.section) as? LWMeSettingGroupModel else {
            return UITableViewCell()
        }
        if (groupModel.cells.count) > indexPath.item {
            let arrayModel = groupModel.cells
            self.drawModel.drawSetting(tableView: tableView, cell: cell as! LWMeSettingTableViewCell, model: arrayModel.object(at: indexPath.item) as! LWMeSettingGroupCellModel)
            return cell!
        }
        else {
            return UITableViewCell()
        }
    }
}
// =================================================================================================================================

