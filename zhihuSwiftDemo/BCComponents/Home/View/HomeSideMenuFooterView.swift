//
//  HomeSideMenuFooterView.swift
//  zhihuSwiftDemo
//
//  Created by Afluy on 16/8/15.
//  Copyright © 2016年 helios. All rights reserved.
//

import Foundation
import UIKit

class HomeSideMenuFooterView: UIView {
    
    var downloadButton: UIButton!
    var stateButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupView() {
        self.downloadButton = WLYHorizontalLayoutButton(type: .Custom)
        self.addSubview(self.downloadButton)
        self.downloadButton.setTitle("离线", forState: .Normal)
        self.downloadButton.setTitleColor(UIColor.wly_darkTextColor, forState: .Normal)
        self.downloadButton.setImage(UIImage(named: "Menu_Download"), forState: .Normal)
        self.downloadButton.titleLabel?.font = UIFont.systemFontOfSize(13)
        self.downloadButton.snp_makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.left.equalTo(self).offset(15)
            make.height.equalTo(30)
        }
        
        self.stateButton = WLYHorizontalLayoutButton(type: .Custom)
        self.addSubview(self.stateButton)
        self.stateButton.setTitle("夜间", forState: .Normal)
        self.stateButton.setTitleColor(UIColor.wly_darkTextColor, forState: .Normal)
        self.stateButton.setImage(UIImage(named: "Menu_Dark"), forState: .Normal)
        self.stateButton.titleLabel?.font = UIFont.systemFontOfSize(13)
        self.stateButton.snp_makeConstraints { (make) in
            make.centerY.equalTo(self.downloadButton)
            make.height.width.equalTo(self.downloadButton)
            make.left.equalTo(self.downloadButton.snp_right).offset(30)
            make.right.equalTo(self).offset(-15)
        }
    }
}