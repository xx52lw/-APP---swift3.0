//
//  LWHomeChannelView.swift
//  dangtangDemo
//
//  Created by liwei on 16/12/10.
//  Copyright © 2016年 张星星. All rights reserved.
//

import UIKit
// =================================================================================================================================
// MARK: - 首页频道选择视图代理方法
protocol LWHomeChannelViewDelegate : NSObjectProtocol {
    // 选择某个频道
    func homeChannelView(view : LWHomeChannelView, selectIndex: Int)
    // 选择选择按钮
    func homeChannelView(view : LWHomeChannelView, selectBtn: UIButton)
}
// =================================================================================================================================
// MARK: - 首页频道选择视图
class LWHomeChannelView: UIView {
    // 设置代理
    weak var delegate: LWHomeChannelViewDelegate?
    // 频道数据数组
    var cellArray = [LWHomeChannelRequestInfo]()
    var selectCell : LWHomeChannelCell?
    // 功能选择按钮
    lazy var selectBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor.clear
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        btn.setTitleColor(UIColor.black, for: UIControlState.normal)
        btn.setTitleColor(LWGlobalRed(), for: UIControlState.selected)
        btn.setTitle("选择", for:.normal)
        btn.addTarget(self, action: #selector(selectBtnClick), for: UIControlEvents.touchUpInside)
        return btn
    }()
    /// 布局
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0 // 行间距
        layout.minimumInteritemSpacing = 0 // 列间距
        layout.scrollDirection = .horizontal
        let collectview = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectview.register(LWHomeChannelCell.self, forCellWithReuseIdentifier: "LWHomeChannelCell")
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
        addSubview(selectBtn)
        loadChannelData()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        selectBtn.sizeToFit()
        var w = selectBtn.frame.size.width + 10.0
        var h = self.bounds.size.height
        var x = self.bounds.size.width - w
        var y = (self.bounds.size.height - h) * 0.5
        selectBtn.frame = CGRect.init(x: x, y: y, width: w, height: h)
        
        x = 0.0
        y = 0.0
        w = selectBtn.frame.minX
        h = self.bounds.size.height
        collectionView.frame = CGRect.init(x: x, y: y, width: w, height: h)
    }
}
// =================================================================================================================================
// MARK: - 首页频道选择视图
extension LWHomeChannelView {
    // 加载频道数据
    func loadChannelData() {
        let channel = LWHomeChannelData()
        let info = LWUserInfoModel.sharedInstance().getUserInfo()
        channel.gender = info.sex
        channel.generation = 1
        let dict = LWNetWorkingTool<LWHomeChannelData>.getDictinoary(model: channel)
        weak var wself = self
        LWNetWorkingTool<LWHomeChannelRequestData>.getDataFromeServiceRequest(url: LWHomeChannelDataUrl, params: dict, successBlock: {
            (jsonModel) in
            wself?.cellArray.removeAll()
            
            for index in 0..<(jsonModel?.channels)!.count {
                let info : LWHomeChannelRequestInfo = (jsonModel?.channels)![index]
                info.itemSize = LWHomeTools.sizeChannelItem(title: (info.name)!, font:  UIFont.systemFont(ofSize: 13))
                if info.editable == true {
                    wself?.cellArray.append(info)
                }
            }
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: LWHomeChannlCompleteNotify), object: wself?.cellArray)
            wself?.collectionView.reloadData()
        }) { (error) in
            
        }
    }
    
    func selectBtnClick(btn : UIButton) {
        delegate?.homeChannelView(view: self, selectBtn: btn)
    }
    
}
// =================================================================================================================================
// MARK: - UICollectionView的代理和数据源方法
extension LWHomeChannelView: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
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
        var  count : CGFloat = 1
        if cellArray.count > 0 {
            count = CGFloat(cellArray.count)
        }
        return CGSize.init(width: collectionView.frame.size.width / count, height: collectionView.frame.size.height)
    }
    // 设置元素样式
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LWHomeChannelCell", for: indexPath) as! LWHomeChannelCell
        cell.backgroundColor = UIColor.clear
        let dataModel = cellArray[indexPath.row] as LWHomeChannelRequestInfo
        cell.nameBtn.frame = cell.bounds
        cell.nameBtn.setTitle(dataModel.name, for: UIControlState.normal)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (selectCell != nil) {
            selectCell?.nameBtn.isSelected = false
        }
        selectCell = collectionView.cellForItem(at: indexPath) as? LWHomeChannelCell
        let dataModel = cellArray[indexPath.row] as LWHomeChannelRequestInfo
        selectCell?.nameBtn.isSelected = true
        delegate?.homeChannelView(view: self, selectIndex: dataModel.id!)
    }
    
}
// =================================================================================================================================

