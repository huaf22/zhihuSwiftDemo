//
//  WLYArticleTableViewCell.swift
//  zhihuSwiftDemo
//
//  Created by Afluy on 16/7/30.
//  Copyright © 2016年 helios. All rights reserved.
//

import UIKit
import SnapKit

class WLYArticleTableViewCell: WLYTableViewCell {
    var logoImageView: UIImageView!
    var titleLabel : UILabel!

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        loadContentView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func loadContentView() {
        self.logoImageView = UIImageView();
        self.contentView.addSubview(self.logoImageView);
        self.logoImageView.snp.makeConstraints() { (make) in
            make.centerY.equalTo(self.contentView)
            make.right.equalTo(self.contentView).offset(-10)
            make.width.height.equalTo(35)
        }
        
        self.titleLabel = UILabel();
        self.contentView.addSubview(self.titleLabel)
        self.titleLabel.numberOfLines = 2
        self.titleLabel.font = UIFont.systemFont(ofSize: 15)
        self.titleLabel.snp.makeConstraints(){ (make) in
            make.left.equalTo(self.contentView).offset(10)
            make.right.equalTo(self.logoImageView!.snp.left).offset(-10)
            make.top.bottom.equalTo(self.contentView)
        }
    }
}
