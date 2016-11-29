//
//  LWGiftCollectionViewCell.swift
//  dangtangDemo
//
//  Created by 张星星 on 16/11/30.
//  Copyright © 2016年 张星星. All rights reserved.
//

import UIKit

class LWGiftCollectionViewCell: UICollectionViewCell {
    // MARK: 懒加载imageView
    lazy var imageView : UIImageView = {
        let imageV = UIImageView()
        imageV.backgroundColor = UIColor.clear
        imageV.contentMode = .scaleAspectFit
        return imageV
        
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.black
        return label
    }()
    
    
}
