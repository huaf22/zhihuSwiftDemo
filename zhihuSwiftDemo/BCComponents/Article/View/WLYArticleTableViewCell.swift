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

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        loadContentView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var logoImageView: UIImageView?
    var titleLabel : UILabel?
    
    func loadContentView() {
        self.logoImageView = UIImageView();
        self.logoImageView?.backgroundColor = UIColor.redColor();
        self.contentView.addSubview(self.logoImageView!);
        self.logoImageView?.snp_makeConstraints() { (make) in
            make.centerY.equalTo(self.contentView)
            make.right.equalTo(self.contentView).offset(-10)
            make.width.height.equalTo(35)
        }
        
        self.titleLabel = UILabel();
        self.titleLabel?.text = "text";
        self.titleLabel?.backgroundColor = UIColor.greenColor()
        self.contentView.addSubview(self.titleLabel!)
        self.titleLabel?.snp_makeConstraints(){ (make) in
            make.left.equalTo(self.contentView).offset(10)
            make.right.equalTo(self.logoImageView!.snp_left).offset(-10)
            make.top.bottom.equalTo(self.contentView)
        }
    }
}
