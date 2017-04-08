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
    /// 请求的URL
    var URLString: String?
    /// 当前页码
    var currentPage = 0
    // banner数据数组
    var cellArray = [LWHomeRequestDataInfo]()
    /// 懒加载视图列表
    lazy var tabelView: UITableView = {
        let view = UITableView.init(frame: CGRect.zero, style: UITableViewStyle.plain)
        view.backgroundColor = UIColor.clear
        view.delegate = self
        view.dataSource = self
        return view
    }()
    /// 懒加载下拉刷新
    lazy var refreshHeader: MJRefreshNormalHeader = {
        let header = MJRefreshNormalHeader(refreshingTarget:self ,refreshingAction:#selector(loadNew))
        header?.stateLabel.isHidden = true
        return header!
    }()
    /// 懒加载上拉刷新
    lazy var refreshFooter: MJRefreshBackNormalFooter = {
        let Footer = MJRefreshBackNormalFooter(refreshingTarget:self ,refreshingAction:#selector(loadMore))
        Footer?.stateLabel.isHidden = true
        return Footer!
    }()
    //MARK: 重写init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(tabelView)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: LWHomeShowChannlNotify), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(homeShowChannlNotify), name: NSNotification.Name(rawValue: LWHomeShowChannlNotify), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(refreshView), name:NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }
    //MARK: 重写deinit
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    //MARK: 重写layoutSubviews
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
    // 旋转刷新视图
    func refreshView() {
        tabelView.reloadData()
    }
    /// 加载最新数据
    func loadNew() {
        refreshHeader.beginRefreshing()
        currentPage = 0
        loadServiceData()
    }
    /// 加载更多数据
    func loadMore() {
        refreshFooter.beginRefreshing()
        currentPage = currentPage + 1
        loadServiceData()
    }
    /// 加载服务器数据
    func loadServiceData() {
        let homeData = LWHomeData()
        let info = LWUserInfoModel.sharedInstance().getUserInfo()
        homeData.gender = info.sex
        homeData.generation = 1
        homeData.limit = 20
        homeData.offset = currentPage
        let dict = LWNetWorkingTool<LWHomeData>.getDictinoary(model: homeData)
        weak var wself = self
        LWNetWorkingTool<LWHomeRequestData>.getDataFromeServiceRequest(url: URLString!, params: dict , successBlock:
            { jsonModel in
                if (wself?.currentPage)! == 0 {
                    wself?.cellArray.removeAll()
                    wself?.cellArray = (wself?.cellArray)! + (jsonModel?.items)!
                }
                else {
                    if (jsonModel?.items?.count)! <= 0 {
                        if (wself?.currentPage)! > 1 {
                            self.currentPage = self.currentPage - 1
                        }
                    }
                    wself?.cellArray = (wself?.cellArray)! + (jsonModel?.items)!
                }
                wself?.tabelView.reloadData()
                print("first: \(jsonModel)")
                wself?.refreshHeader.endRefreshing()
                wself?.refreshFooter.endRefreshing()
                
        }) { (error) in
            wself?.refreshHeader.endRefreshing()
            wself?.refreshFooter.endRefreshing()
        }
    }
    
    // 收藏按钮点击
    func collectBtnClick(btn: UIButton) {
        let info = LWUserInfoModel.sharedInstance().getUserInfo()
        if info.isExpiration == false{
            
            print(btn)
        }
        print(btn)
    }
    
    // 展示视图通知
    func homeShowChannlNotify(notify: Notification?) {
        let info = notify?.object as! LWHomeChannelRequestInfo
        URLString = LWHomeDataUrl + (NSString.init(format: "%ld", info.id!) as String)  + "/items?"
        //        let showIndex = notify?.object as! IndexPath
        if (info.index != self.tag || cellArray.count > 0) {
            return
        }
        currentPage = 0
        loadServiceData()
    }

}
// =================================================================================================================================
// MARK: - 普通视图
extension LWHomeTableView : UITableViewDelegate,UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return cellArray.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return (tableView.frame.size.width * LWHomeCellHeightWidth)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = LWHomeTableViewCell.createCell(tableView: tableView, identifier: "LWHomeTableViewCell")
        var info = LWHomeRequestDataInfo()
        if cellArray.count > indexPath.row {
            info = cellArray[indexPath.row]
        }
        LWHomeDrawModel.drawHomeCell(tableView: tableView, cell: cell, info: info)
        cell.collectBtn.tag = indexPath.row
        cell.collectBtn.addTarget(self, action: #selector(collectBtnClick), for: UIControlEvents.touchUpInside)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var info = LWHomeRequestDataInfo()
        if cellArray.count > indexPath.row {
            info = cellArray[indexPath.row]
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: LWHomeShowProductNotify), object: info)
    }
}

// =================================================================================================================================

