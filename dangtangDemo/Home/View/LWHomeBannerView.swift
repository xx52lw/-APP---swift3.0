//
//  LWHomeBannerView.swift
//  dangtangDemo
//
//  Created by liwei on 16/12/10.
//  Copyright © 2016年 张星星. All rights reserved.
//

import UIKit
// =================================================================================================================================
// MARK: - 精选带banner视图
class LWHomeBannerView: UIView {
    // banner数据数组
    var cellArray = [LWHomeBannerRequestData]()
    /// 布局banner
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0 // 行间距
        layout.minimumInteritemSpacing = 0 // 列间距
        layout.scrollDirection = .horizontal
        let collectview = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectview.register(LWHomeBannerCollectionViewCell.self, forCellWithReuseIdentifier: "LWHomeBannerCollectionViewCell")
        collectview.backgroundColor = UIColor.clear
        collectview.showsVerticalScrollIndicator = true
        collectview.delegate = self
        collectview.dataSource = self
        //        collectview.contentInset = UIEdgeInsets.init(top: 5, left: 0, bottom:0, right: 0)
        return collectview
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(collectionView)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = self.bounds
    }

    
}
// =================================================================================================================================
// MARK: - 首页频道选择视图
extension LWHomeBannerView {
    // 加载banner数据
    func loadChannelData() {
        weak var wself = self
        LWNetWorkingTool<LWHomeBannerData>.getDataFromeServiceRequest(url: LWHomeBannerDataUrl, successBlock: {
            (jsonModel) in
            wself?.cellArray.removeAll()
            wself?.cellArray = (wself?.cellArray)! + (jsonModel?.banners)!
            wself?.collectionView.reloadData()
        }) { (error) in
        
        }
        
    }
    
}

// =================================================================================================================================
// MARK: - UICollectionView的代理和数据源方法
extension LWHomeBannerView: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
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
        return CGSize.init(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
    }
    // 设置元素样式
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LWHomeBannerCollectionViewCell", for: indexPath) as! LWHomeBannerCollectionViewCell
        cell.backgroundColor = UIColor.clear
        let dataModel = cellArray[indexPath.row] as LWHomeBannerRequestData
        LWImageTool.imageUrlAndPlaceImage(imageView: cell.imageView, stringUrl: dataModel.image_url, placeholdImage: LWGlobalPlaceHolderImage)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        let dataModel = cellArray[indexPath.row] as LWHomeBannerRequestData
       
    }
    
}
// =================================================================================================================================



// =================================================================================================================================
