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
        self.downloadButton = WLYHorizontalLayoutButton(type: .custom)
        self.addSubview(self.downloadButton)
        self.downloadButton.setTitle("离线", for: UIControlState())
        self.downloadButton.setTitleColor(UIColor.wly_darkTextColor, for: UIControlState())
        self.downloadButton.setImage(UIImage(named: "Menu_Download"), for: UIControlState())
        self.downloadButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        self.downloadButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.left.equalTo(self).offset(15)
            make.height.equalTo(30)
        }
        
        self.stateButton = WLYHorizontalLayoutButton(type: .custom)
        self.addSubview(self.stateButton)
        self.stateButton.setTitle("夜间", for: UIControlState())
        self.stateButton.setTitleColor(UIColor.wly_darkTextColor, for: UIControlState())
        self.stateButton.setImage(UIImage(named: "Menu_Dark"), for: UIControlState())
        self.stateButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        self.stateButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.downloadButton)
            make.height.width.equalTo(self.downloadButton)
            make.left.equalTo(self.downloadButton.snp.right).offset(30)
            make.right.equalTo(self).offset(-15)
        }
    }
}
