//
//  LWHomeBannerTableView.swift
//  dangtangDemo
//
//  Created by liwei on 16/12/10.
//  Copyright © 2016年 张星星. All rights reserved.
//

import UIKit
// =================================================================================================================================
// MARK: - 精选视图
class LWHomeBannerTableView: UIView {
    
    /// 频道数据
    var bannerInfo: LWHomeChannelRequestInfo?
    /// 请求的URL
    var URLString: String = LWHomeDataUrl
    /// 当前页码
    var currentPage = 0
    // banner数据数组
    var cellArray = [LWHomeRequestDataInfo]()
    /// 懒加载视图列表
    lazy var tabelView: UITableView = {
        let view = UITableView.init(frame: CGRect.zero, style: UITableViewStyle.grouped)
        view.backgroundColor = UIColor.clear
        view.delegate = self
        view.dataSource = self
        return view
    }()
    lazy var refreshHeader: MJRefreshNormalHeader = {
        let header = MJRefreshNormalHeader(refreshingTarget:self ,refreshingAction:#selector(loadNew))
        header?.stateLabel.isHidden = true
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
extension LWHomeBannerTableView {
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
        let giftData = LWGiftData()
        let info = LWUserInfoModel.sharedInstance().getUserInfo()
        giftData.gender = info.sex
        giftData.generation = 1
        giftData.limit = 20
        giftData.offset = currentPage
        let dict = LWNetWorkingTool<LWHomeData>.getDictinoary(model: giftData)
        weak var wself = self
        LWNetWorkingTool<LWHomeRequestData>.getDataFromeServiceRequest(url: URLString, params: dict , successBlock:
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
    // 展示view数据
    func showView() {

        URLString = URLString + (NSString.init(format: "%ld", (bannerInfo?.id)!) as String)  + "/items?"
        if cellArray.count <= 0 {
            currentPage = 0
            loadServiceData()
        }
    }
    // 收藏按钮点击
    func collectBtnClick(btn: UIButton) {
        print(btn)
    }
}
// =================================================================================================================================
// MARK: - 精选视图
extension LWHomeBannerTableView : UITableViewDelegate,UITableViewDataSource {
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        else {
           return cellArray.count
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      
            return (tableView.frame.size.width / LWHomeCellWidthHeight)

    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.section == 0 {
            let cell = LWHomeTableViewCell.createCell(tableView: tableView, identifier: "LWHomeTableViewCellBanner")
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            let bannerView = LWHomeBannerView()
            bannerView.frame = CGRect.init(x: 0, y: 0, width: tableView.frame.size.width, height: (tableView.frame.size.width / LWHomeCellWidthHeight))
            bannerView.loadChannelData()
            cell.contentView.addSubview(bannerView)
           return cell
        }
        else {
            let cell = LWHomeTableViewCell.createCell(tableView: tableView, identifier: "LWHomeTableViewCell")
            var info = LWHomeRequestDataInfo()
            if cellArray.count > indexPath.row {
                info = cellArray[indexPath.row]
            }
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            var y : CGFloat = 0
            var x : CGFloat = 0
            var w : CGFloat = tableView.frame.size.width
            var h : CGFloat = (tableView.frame.size.width / LWHomeCellWidthHeight)
            cell.coverImageView.frame = CGRect.init(x: 5, y: 5, width: w - 10, height: h - 5)
            LWImageTool.imageUrlAndPlaceImage(imageView: (cell.coverImageView), stringUrl: info.cover_image_url, placeholdImage: LWGlobalPlaceHolderImage)
            cell.coverImageView.layer.cornerRadius = 5.0
            cell.coverImageView.layer.masksToBounds = true
            let image = UIImage.getImageFromeBundleFile(fileName: "comment", imageName: "likeCount")
            let likeCount = (NSString.init(format: "%ld", info.likes_count!) as String)
            let likeSize = LWUITool.sizeWithStringFont(likeCount, font: UIFont.systemFont(ofSize: 10.0), maxSize: CGSize.init(width: cell.coverImageView.frame.size.width, height: 200))
            w = image.size.width + likeSize.width + 10
            y = cell.coverImageView.frame.minY + 5.0
            x = cell.coverImageView.frame.maxX - w - y
            h = likeSize.height + 10
            cell.collectBtn.tag = indexPath.row
            cell.collectBtn.addTarget(self, action: #selector(collectBtnClick), for: UIControlEvents.touchUpInside)
            cell.collectBtn.frame = CGRect.init(x: x, y: y, width: w, height: h)
            cell.collectBtn.backgroundColor = UIColor.gray
            cell.collectBtn.setTitle(likeCount, for: .normal)
            cell.collectBtn.setImage(image, for: .normal)
            cell.collectBtn.alpha = 0.8
            cell.collectBtn.layer.cornerRadius = h * 0.5
            cell.collectBtn.layer.masksToBounds = true
            cell.collectBtn.titleLabel?.font = UIFont.systemFont(ofSize: 9)
            
            let title = info.title!
            let titleSize = LWUITool.sizeWithStringFont(title, font: UIFont.systemFont(ofSize: 13.0), maxSize: CGSize.init(width: cell.coverImageView.frame.size.width, height: 200))
            x = cell.coverImageView.frame.minX + 5.0
            h = titleSize.height
            w = cell.coverImageView.frame.width
            y = cell.coverImageView.frame.maxY - h - 5.0
            cell.titleLabel.frame = CGRect.init(x: x, y: y, width: w, height: h)
            cell.titleLabel.text = title
            cell.titleLabel.font = UIFont.systemFont(ofSize: 13.0)
            return cell
        }

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

// =================================================================================================================================
