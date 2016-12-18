//
//  LWCategoryCompilationsView.swift
//  dangtangDemo
//
//  Created by liwei on 16/12/18.
//  Copyright © 2016年 张星星. All rights reserved.
//

import UIKit
// =================================================================================================================================
// MARK: - 专题集合视图代理方法
protocol LWCategoryCompilationsViewDelegate : NSObjectProtocol {
/// 点击分类
    func clickItem(view: LWCategoryCompilationsView, info: LWCategoryCompilationsRequestDataInfo)
}
// =================================================================================================================================
// MARK: - 专题集合视图
class LWCategoryCompilationsView: UIView {

    /// 视图控制器
    var vc : AnyObject?
    //MARK: 标题标签
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.white
        label.text = "专题集合"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.black
        label.sizeToFit()
        label.frame = CGRect.init(x: 0.0, y: 0.0, width: label.frame.size.width, height: label.frame.size.height)
        return label
    }()
    //MARK: 查看全部
    lazy var checkBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor.clear
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        btn.setTitle("查看全部>", for: UIControlState.normal)
        btn.setTitleColor(UIColor.gray, for: UIControlState.normal)
        btn.sizeToFit()
        btn.frame = CGRect.init(x: 0.0, y: 0.0, width: btn.frame.size.width, height: btn.frame.size.height)
        return btn
    }()
    //MARK: CELL宽度
    var cellWidth : CGFloat = 0
    // 集合数据数组
    var cellArray = [LWCategoryCompilationsRequestDataInfo]()
    //MARK: 内容view
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10.0
        layout.minimumLineSpacing = 10.0
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal
        let view = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        view.register(LWCategoryCompilationsViewCell.self, forCellWithReuseIdentifier: "LWCategoryCompilationsViewCell")
        view.backgroundColor = UIColor.white
        view.delegate = self
        view.dataSource = self
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    // MARK: 重写系统init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViewSubviews()
    }
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented")}
    /// 获取视图的高度并且布局
    func getViewHeightWithLayoutViews(width: CGFloat) -> CGFloat {
        cellWidth = 150.0
        let margin : CGFloat = 10.0
        var x : CGFloat = margin
        var y : CGFloat = margin
        var w : CGFloat = titleLabel.frame.size.width
        var h : CGFloat = titleLabel.frame.size.height
        titleLabel.frame = CGRect.init(x: x, y: y, width: w, height: h)
        
        w = checkBtn.frame.size.width
        h = checkBtn.frame.size.height
        x = width - w - margin
        y = titleLabel.frame.midY - h * 0.5
        checkBtn.frame = CGRect.init(x: x, y: y, width: w, height: h)
        
        x = titleLabel.frame.minX
        w = width
        h = cellWidth * LHCategoryCellHeightWidth
        y = titleLabel.frame.maxY + margin
        collectionView.frame = CGRect.init(x: x, y: y, width: w, height: h)
        return collectionView.frame.maxY + margin
    }
}
// =================================================================================================================================
// MARK: - 专题集合视图
extension LWCategoryCompilationsView {
  
    //MARK: 添加子控件
    func addViewSubviews() {
        addSubview(titleLabel)
        addSubview(checkBtn)
        addSubview(collectionView)
        loadChannelData()
    }
   // 获取cell数据
    func loadChannelData() {
        let data = LWCategoryCompilationsData()
        data.limit = 20
        data.offset = 0
        let dict = LWNetWorkingTool<LWCategoryCompilationsData>.getDictinoary(model: data)
        weak var wself = self
        LWNetWorkingTool<LWCategoryCompilationsRequestData>.getDataFromeServiceRequest(url: LWCategoryCompilationsDataUrl, params: dict, successBlock: {
            (jsonModel) in
            wself?.cellArray.removeAll()
            guard let array = jsonModel?.collections else {
                return
            }
            wself?.cellArray = array
            wself?.collectionView.reloadData()
        }) { (error) in
            
        }
    }

}
// =================================================================================================================================
// MARK: - 专题集合视图
extension LWCategoryCompilationsView : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    //MARK: cell数量
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellArray.count
    }
    //MARK: cellSize
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize.init(width: cellWidth, height: cellWidth * LHCategoryCellHeightWidth)
    }
    //MARK: cell样式
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LWCategoryCompilationsViewCell", for: indexPath) as! LWCategoryCompilationsViewCell
        cell.backgroundColor = UIColor.clear
        var dataModel : LWCategoryCompilationsRequestDataInfo?
        if cellArray.count > indexPath.row {
            dataModel = cellArray[indexPath.row] as LWCategoryCompilationsRequestDataInfo
        }
        LWImageTool.imageUrlAndPlaceImage(imageView: cell.coverImageView, stringUrl: dataModel?.banner_image_url, placeholdImage: LWGlobalPlaceHolderImage)
        cell.coverImageView.frame = cell.bounds
        cell.coverImageView.layer.cornerRadius = 3.0
        cell.coverImageView.layer.masksToBounds = true
        return cell
    }
    //MARK: 选中某个cell 
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = vc as! LWViewControllerBase
        let vcController = LWCategoryListsViewController()
        var dataModel : LWCategoryCompilationsRequestDataInfo?
        if cellArray.count > indexPath.row {
            dataModel = cellArray[indexPath.row] as LWCategoryCompilationsRequestDataInfo
        }
        vcController.title = dataModel?.title
        vcController.URLString = LWCategoryCompilationsListsDataUrl + (NSString.init(format: "%ld", (dataModel?.id!)!) as String)  + "/posts?"
        controller.navigationController?.pushViewController(vcController, animated: true)
    }
}
// =================================================================================================================================

