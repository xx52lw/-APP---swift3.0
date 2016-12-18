//
//  LWCategoryListsViewController.swift
//  dangtangDemo
//
//  Created by liwei on 16/12/18.
//  Copyright © 2016年 张星星. All rights reserved.
//

import UIKit

class LWCategoryListsViewController: LWViewControllerBase {

    /// 请求的URL
    var URLString: String?
    /// 当前页码
    var currentPage = 0
    // banner数据数组
    var cellArray = [LWCategoryCompilationsListsRequestDataInfo]()
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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tabelView)
        loadServiceData()
        // Do any additional setup after loading the view.
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tabelView.frame = view.bounds
    }

}

// =================================================================================================================================
// MARK: - 普通视图
extension LWCategoryListsViewController {
    
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
        let data = LWCategoryCompilationsListsData()
        let info = LWUserInfoModel.sharedInstance().getUserInfo()
        data.gender = info.sex
        data.generation = 1
        data.limit = 20
        data.offset = currentPage
        let dict = LWNetWorkingTool<LWCategoryCompilationsListsData>.getDictinoary(model: data)
        weak var wself = self
        LWNetWorkingTool<LWCategoryCompilationsListsRequestData>.getDataFromeServiceRequest(url: URLString!, params: dict , successBlock:
            { jsonModel in
                if (wself?.currentPage)! == 0 {
                    wself?.cellArray.removeAll()
                    wself?.cellArray = (wself?.cellArray)! + (jsonModel?.posts)!
                }
                else {
                    if (jsonModel?.posts?.count)! <= 0 {
                        if (wself?.currentPage)! > 1 {
                            self.currentPage = self.currentPage - 1
                        }
                    }
                    wself?.cellArray = (wself?.cellArray)! + (jsonModel?.posts)!
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
        print(btn)
    }
    

}
// =================================================================================================================================
// MARK: - 普通视图 tableView代理和数据源方法
extension LWCategoryListsViewController : UITableViewDelegate,UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellArray.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (tableView.frame.size.width * LWHomeCellHeightWidth)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = LWCategoryListsViewCellTableViewCell.createCell(tableView: tableView, identifier: "LWCategoryListsViewCellTableViewCell")
        var info = LWCategoryCompilationsListsRequestDataInfo()
        if cellArray.count > indexPath.row {
            info = cellArray[indexPath.row]
        }
        LWCategoryDrawModel.drawHomeCell(tableView: tableView, cell: cell, info: info)
        cell.collectBtn.tag = indexPath.row
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var info = LWCategoryCompilationsListsRequestDataInfo()
        if cellArray.count > indexPath.row {
            info = cellArray[indexPath.row]
        }
        let detailVC = LWHomeProductDetailViewController()
        detailVC.url = LWProductDetailDataUrl + (NSString.init(format: "%ld", info.id!) as String)  + "?"
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

// =================================================================================================================================

