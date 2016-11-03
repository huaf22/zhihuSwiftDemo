//
//  WLYCollectionViewCell.swift
//  zhihuSwiftDemo
//
//  Created by Afluy on 16/9/5.
//  Copyright © 2016年 helios. All rights reserved.
//

import UIKit

class WLYCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    static var identifier: String {
        return NSStringFromClass(WLYCollectionViewCell.self)
    }
    
}
