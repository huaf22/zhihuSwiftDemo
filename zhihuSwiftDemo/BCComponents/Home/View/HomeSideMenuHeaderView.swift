//
//  HomeSideMenuHeaderView.swift
//  zhihuSwiftDemo
//
//  Created by Afluy on 16/8/15.
//  Copyright © 2016年 helios. All rights reserved.
//

import Foundation
import UIKit

class HomeSideMenuHeaderView: UIView {
    
    var logoImageView: UIImageView!
    var nameLabel: UILabel!
    var likeButton: UIButton!
    var messageButton: UIButton!
    var settingButton: UIButton!

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupView() {
        self.logoImageView = UIImageView()
        self.addSubview(self.logoImageView)
        self.logoImageView.image = UIImage(named: "Dark_Account_Avatar")
        self.logoImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(30)
            make.left.equalTo(self).offset(15)
            make.width.height.equalTo(35)
        }
        
        self.nameLabel = UILabel()
        self.addSubview(self.nameLabel)
        self.nameLabel.text = "name"
        self.nameLabel.textColor = UIColor.wly_darkTextColor
        self.nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.logoImageView.snp.right).offset(15)
            make.centerY.equalTo(self.logoImageView)
        }
        
        self.messageButton = WLYVerticalLayoutButton(type: .custom)
        self.addSubview(self.messageButton)
        self.messageButton.setImage(UIImage(named: "Menu_Icon_Message"), for: UIControlState())
        self.messageButton.setTitleColor(UIColor.wly_darkTextColor, for: UIControlState())
        self.messageButton.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        self.messageButton.setTitle("消息", for: UIControlState())
        self.messageButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.logoImageView.snp.bottom).offset(15)
            make.height.equalTo(35)
            make.width.equalTo(50)
            make.centerX.equalTo(self)
        }
        
        self.likeButton = WLYVerticalLayoutButton(type: .custom)
        self.addSubview(self.likeButton)
        self.likeButton.setImage(UIImage(named: "Menu_Icon_Collect"), for: UIControlState())
        self.likeButton.setTitleColor(UIColor.wly_darkTextColor, for: UIControlState())
        self.likeButton.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        self.likeButton.setTitle("收藏", for: UIControlState())
        self.likeButton.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self.messageButton)
            make.width.equalTo(self.messageButton)
            make.right.equalTo(self.messageButton.snp.left).offset(-15)
        }
        
        self.settingButton = WLYVerticalLayoutButton(type: .custom)
        self.addSubview(self.settingButton)
        self.settingButton.setImage(UIImage(named: "Menu_Icon_Setting"), for: UIControlState())
        self.settingButton.setTitleColor(UIColor.wly_darkTextColor, for: UIControlState())
        self.settingButton.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        self.settingButton.setTitle("设置", for: UIControlState())
        self.settingButton.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self.messageButton)
            make.width.equalTo(self.messageButton)
            make.left.equalTo(self.messageButton.snp.right).offset(15)
        }
    }
}
