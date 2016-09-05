//
//  WLYTableViewCell.swift
//  zhihuSwiftDemo
//
//  Created by Afluy on 16/8/8.
//  Copyright © 2016年 helios. All rights reserved.
//

import UIKit

class WLYTableViewCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    static var identifier: String {
        return NSStringFromClass(WLYTableViewCell)
    }
}
