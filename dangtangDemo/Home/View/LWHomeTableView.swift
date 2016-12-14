//
//  LWHomeTableView.swift
//  dangtangDemo
//
//  Created by liwei on 16/12/13.
//  Copyright © 2016年 张星星. All rights reserved.
//

import UIKit
// =================================================================================================================================
// MARK: - 普通视图
class LWHomeTableView: UIView {

    /// 频道数据
    var bannerInfo: LWHomeChannelRequestInfo?
    /// 当前页码
    var currentPage = 0
    // banner数据数组
    var cellArray = [LWHomeBannerRequestData]()
    /// 懒加载视图列表
    lazy var tabelView: UITableView = {
        let view = UITableView.init(frame: CGRect.zero, style: UITableViewStyle.plain)
        view.backgroundColor = UIColor.clear
        view.delegate = self
        view.dataSource = self
        return view
    }()
    lazy var refreshHeader: MJRefreshNormalHeader = {
        let header = MJRefreshNormalHeader(refreshingTarget:self ,refreshingAction:#selector(loadNew))
        header?.stateLabel.isHidden = true
        header?.beginRefreshing(completionBlock: {
            print("")
        })
        return header!
    }()
    lazy var refreshFooter: MJRefreshBackNormalFooter = {
        let Footer = MJRefreshBackNormalFooter(refreshingTarget:self ,refreshingAction:#selector(loadMore))
        Footer?.stateLabel.isHidden = true
        return Footer!
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(tabelView)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        tabelView.frame = self.bounds
        tabelView.mj_header = refreshHeader
        tabelView.mj_footer = refreshFooter
    }
    
}
// =================================================================================================================================
// MARK: - 工具方法
extension LWHomeTableView {
    /// 加载最新数据
    func loadNew() {
        print("")
        currentPage = 0
        loadServiceData()
    }
    /// 加载更多数据
    func loadMore() {
        currentPage = currentPage + 1
        loadServiceData()
    }
    /// 加载服务器数据
    func loadServiceData() {
        let giftData = LWGiftData()
        let info = LWUserInfoModel.sharedInstance().getUserInfo()
        giftData.gender = info.sex
        giftData.generation = 1
        giftData.limit = 20
        giftData.offset = currentPage
        let dict = LWNetWorkingTool<LWGiftData>.getDictinoary(model: giftData)
        weak var wself = self
        LWNetWorkingTool<LWGiftRequestData>.getDataFromeServiceRequest(url: LWGiftDataUrl, params: dict , successBlock:
            { jsonModel in
                //                if (wself?.currentPage)! == 0 {
                //                    wself?.cellArray.removeAll()
                //                    wself?.cellArray = (wself?.cellArray)! + (jsonModel?.items)!
                //                }
                //                else {
                //                    if (jsonModel?.items?.count)! <= 0 {
                //                        if (wself?.currentPage)! > 1 {
                //                            self.currentPage = self.currentPage - 1
                //                        }
                //                    }
                //                    wself?.cellArray = (wself?.cellArray)! + (jsonModel?.items)!
                //                }
                //                wself?.collectionView.reloadData()
                print("first: \(jsonModel)")
                wself?.refreshHeader.endRefreshing()
                wself?.refreshFooter.endRefreshing()
                
        }) { (error) in
            wself?.refreshHeader.endRefreshing()
            wself?.refreshFooter.endRefreshing()
        }
        
    }
}
// =================================================================================================================================
// MARK: - 普通视图
extension LWHomeTableView : UITableViewDelegate,UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 3
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
     
        return 100
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "LWHomeTableViewCell")
        if cell == nil {
            cell = LWHomeTableViewCell.init(style: .default, reuseIdentifier: "LWHomeTableViewCell")
        }
        else {
            cell = cell as! LWHomeTableViewCell
        }
        if indexPath.section == 0 {
            
            cell?.backgroundColor = UIColor.red
            
        }
        else {
            cell?.backgroundColor  = UIColor.yellow
        }
        return cell!
    }
}

// =================================================================================================================================

