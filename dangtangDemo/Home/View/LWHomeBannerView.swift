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
        collectview.isPagingEnabled = true
        //        collectview.contentInset = UIEdgeInsets.init(top: 5, left: 0, bottom:0, right: 0)
        return collectview
    }()
    /// 页数控制器
    lazy var pageControl: UIPageControl = {
        let page = UIPageControl()
        page.currentPageIndicatorTintColor = UIColor.white
        page.pageIndicatorTintColor = LWGlobalViewBgColor()
        return page
    }()
    /// 定时器
    var timer: Timer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(collectionView)
        addSubview(pageControl)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = self.bounds
        pageControl.frame = CGRect.init(x: 0, y: self.bounds.size.height - 20.0, width: self.bounds.size.width, height: 20.0)
    }

    
}
// =================================================================================================================================
// MARK: - 首页频道选择视图
extension LWHomeBannerView {
    // 加载banner数据
    func loadChannelData() {
        weak var wself = self
        invalidateTimer()
        LWNetWorkingTool<LWHomeBannerData>.getDataFromeServiceRequest(url: LWHomeBannerDataUrl, successBlock: {
            (jsonModel) in
            wself?.cellArray.removeAll()
            wself?.cellArray = (wself?.cellArray)! + (jsonModel?.banners)!
            wself?.collectionView.reloadData()
            wself?.pageControl.numberOfPages = (wself?.cellArray.count)!
            wself?.beginTimer()
        }) { (error) in
        
        }
        
    }
    // 定时器运行
    func timerRun() {
        if pageControl.currentPage >= (cellArray.count - 1) {
            pageControl.currentPage = 0
            collectionView.scrollToItem(at: IndexPath.init(row: pageControl.currentPage, section: 0), at: UICollectionViewScrollPosition.centeredHorizontally, animated: false)
        }
        else {
            pageControl.currentPage = pageControl.currentPage + 1
            collectionView.scrollToItem(at: IndexPath.init(row: pageControl.currentPage, section: 0), at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)
        }
        
    }
    // 开始定时器
    func beginTimer() {
       invalidateTimer()
       timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(timerRun), userInfo: nil, repeats: true)
       RunLoop.main.add(timer!, forMode: RunLoopMode.commonModes)
       timer?.fire()
    }
    // 取消定时器
    func invalidateTimer() {
        timer?.invalidate()
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
        cell.imageView.frame = cell.bounds
        LWImageTool.imageUrlAndPlaceImage(imageView: cell.imageView, stringUrl: dataModel.image_url, placeholdImage: LWGlobalPlaceHolderImage)
        return cell
    }
    // 选择某个cell
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        let dataModel = cellArray[indexPath.row] as LWHomeBannerRequestData
       
    }
    // 开始滚动
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        invalidateTimer()
    }
    // 结束滚动
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        var index  = Int((collectionView.contentOffset.x + collectionView.frame.size.width * 0.5) / collectionView.frame.size.width)
        if index <= 0 {
            index = 0
        }
        if (index > (cellArray.count - 1)){
            index = cellArray.count - 1
        }
        pageControl.currentPage = index
        beginTimer()
    }
}
// =================================================================================================================================



// =================================================================================================================================
