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
        fatalError("init(coder:) has not been implemented")
    }
    
    static var identifier: String {
        return NSStringFromClass(WLYTableViewCell.self)
    }
}
