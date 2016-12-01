//
//  LWGiftViewController.swift
//  dangtangDemo
//
//  Created by 张星星 on 16/11/22.
//  Copyright © 2016年 张星星. All rights reserved.
//

import UIKit
class LWGiftViewController: LWViewControllerBase {

    /// cell的尺寸
    var cellSize : CGSize?
    /// cell的数组
    var cellArray = [LWGiftRequestDataModel]()
    
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
    /// 布局
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10 // 行间距
        layout.minimumInteritemSpacing = 5 // 列间距
        layout.scrollDirection = .vertical
        let collectview = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectview.register(LWGiftCollectionViewCell.self, forCellWithReuseIdentifier: "LWGiftCollectionViewCell")
        collectview.backgroundColor = UIColor.clear
        collectview.showsVerticalScrollIndicator = true
        collectview.delegate = self
        collectview.dataSource = self
//        collectview.contentInset = UIEdgeInsets.init(top: 5, left: 0, bottom:0, right: 0)
        return collectview
    }()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = nil
        // Do any additional setup after loading the view.
        
//        let width: CGFloat = (LWAppScreenWidth - 20) / 2
//        let height: CGFloat = LWUITool.sizeWithStringFont(<#T##string: String##String#>, font: <#T##UIFont#>, maxSize: <#T##CGSize#>)
//        return CGSizeMake(width, height)
        view.addSubview(collectionView)
        
      //        self.collectionView .addSubview(rh)
        self.collectionView.mj_header = refreshHeader
        self.collectionView.mj_footer = refreshFooter
        
    }
    
    func loadNew() {
       print("")
        let giftData = LWGiftData()
        let info = LWUserInfoModel.sharedInstance().getUserInfo()
        
        giftData.gender = info.sex
        giftData.generation = 1
        giftData.limit = 20
        giftData.offset = 0
        let dict = LWNetWorkingTool<LWGiftData>.getDictinoary(model: giftData)
        weak var wself = self
        LWNetWorkingTool<LWGiftRequestData>.getDataFromeServiceRequest(url: LWGiftDataUrl, params: dict , successBlock:
            { jsonModel in
                wself?.cellArray = (jsonModel?.items)!
                wself?.collectionView.reloadData()
                print("first: \(jsonModel)")
                self.refreshHeader.endRefreshing()
                
        }) { (error) in
            
        }

    }
    func loadMore() {
        print("")
        refreshFooter.endRefreshing()
    }
    override func viewWillLayoutSubviews() {
         super.viewWillLayoutSubviews()
//        collectionView.frame = CGRect.init(x: 5, y: 0, width: view.frame.size.width - 10, height: view.frame.size.height)
        collectionView.frame = view.bounds
    }

}

// =================================================================================================================================
// MARK: - UICollectionView的代理和数据源方法
extension LWGiftViewController: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    // 分组个数
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    // 每组元素个数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellArray.count
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    // 每个cell的尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let w : CGFloat = (LWAppScreenWidth - 30) / 2
        let h : CGFloat = w + 40 + 20 + 5
        return CGSize.init(width: w, height: h)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(10, 10, 0, 10)
    }
    // 设置元素样式
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LWGiftCollectionViewCell", for: indexPath) as! LWGiftCollectionViewCell
        cell.backgroundColor = UIColor.white
        let dataModel = cellArray[indexPath.row] as LWGiftRequestDataModel
        cell.dataInfo = dataModel.data!
        cell.layoutViewSubviews()
        cell.layer.cornerRadius = 2.0
        cell.layer.masksToBounds = true
        return cell
    }
}
// =================================================================================================================================


