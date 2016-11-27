//
//  LWNewFeatureViewController.swift
//  dangtangDemo
//
//  Created by 张星星 on 16/11/25.
//  Copyright © 2016年 张星星. All rights reserved.
//

import UIKit
// =================================================================================================================================
// MARK: - 新特性界面
class LWNewFeatureViewController: UIViewController {
    
    var cellCount = 4
    
    
    /// 布局
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = UIScreen.main.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        let collectview = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectview.register(LWNewFeatureCollectionViewCell.self, forCellWithReuseIdentifier: "LWNewFeatureCollectionViewCell")
        collectview.backgroundColor = UIColor.clear
        collectview.showsHorizontalScrollIndicator = false
        collectview.bounces = false
        collectview.isPagingEnabled = true
        collectview.delegate = self
        collectview.dataSource = self
        return collectview
    }()
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = UIColor.clear
        view.addSubview(collectionView)
    }
    override func viewWillLayoutSubviews() {
        collectionView.frame = view.bounds
    }
}
// =================================================================================================================================
// MARK: - 新特性界面工具
extension LWNewFeatureViewController {
    
  /// 点击进入按钮
    func inputBtnClick(){
       let info = LWUserInfoModel.sharedInstance().getUserInfo()
        UserDefaults.standard.set(Bundle.main.version, forKey: LWSystemVersionKey)
        if info.sex == 0 {
            navigationController?.present(LWSelectInfoViewController(), animated: true, completion: {
                
            })
        }
        else {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: LWNewFeatureCompleteNotify), object: nil)
        }
    }

}

// =================================================================================================================================
// MARK: - UICollectionView的代理和数据源方法
extension LWNewFeatureViewController: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    // 分组个数
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    // 每组元素个数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellCount
    }
    // 设置元素样式
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LWNewFeatureCollectionViewCell", for: indexPath) as! LWNewFeatureCollectionViewCell
        cell.imageView.image = UIImage.getImageFromeBundleFile(fileName: "newFeature", imageName: "walkthrough_\(indexPath.row + 1)")
        if (indexPath.row == (cellCount - 1)) {
            cell.inputBtn.isHidden = false
            cell.inputBtn.addTarget(self, action: #selector(inputBtnClick), for: .touchUpInside)
        }
        else {
            cell.inputBtn.isHidden = true
        }
        return cell
    }
}
// =================================================================================================================================
