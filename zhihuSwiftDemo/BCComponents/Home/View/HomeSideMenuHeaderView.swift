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
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.logoImageView = UIImageView()
        self.addSubview(self.logoImageView)
        self.logoImageView.image = UIImage(named: "Dark_Account_Avatar")
        self.logoImageView.snp_makeConstraints { (make) in
            make.top.equalTo(self).offset(30)
            make.left.equalTo(self).offset(15)
            make.width.height.equalTo(35)
        }
        
        self.nameLabel = UILabel()
        self.addSubview(self.nameLabel)
        self.nameLabel.text = "name"
        self.nameLabel.textColor = UIColor.wly_darkTextColor
        self.nameLabel.snp_makeConstraints { (make) in
            make.left.equalTo(self.logoImageView.snp_right).offset(15)
            make.centerY.equalTo(self.logoImageView)
        }
        
        self.messageButton = WLYVerticalLayoutButton(type: .Custom)
        self.addSubview(self.messageButton)
        self.messageButton.setImage(UIImage(named: "Menu_Icon_Message"), forState: .Normal)
        self.messageButton.setTitleColor(UIColor.wly_darkTextColor, forState: .Normal)
        self.messageButton.titleLabel?.font = UIFont.systemFontOfSize(10)
        self.messageButton.setTitle("消息", forState: .Normal)
        self.messageButton.snp_makeConstraints { (make) in
            make.top.equalTo(self.logoImageView.snp_bottom).offset(15)
            make.height.equalTo(35)
            make.width.equalTo(50)
            make.centerX.equalTo(self)
        }
        
        self.likeButton = WLYVerticalLayoutButton(type: .Custom)
        self.addSubview(self.likeButton)
        self.likeButton.setImage(UIImage(named: "Menu_Icon_Collect"), forState: .Normal)
        self.likeButton.setTitleColor(UIColor.wly_darkTextColor, forState: .Normal)
        self.likeButton.titleLabel?.font = UIFont.systemFontOfSize(10)
        self.likeButton.setTitle("收藏", forState: .Normal)
        self.likeButton.snp_makeConstraints { (make) in
            make.top.bottom.equalTo(self.messageButton)
            make.width.equalTo(self.messageButton)
            make.right.equalTo(self.messageButton.snp_left).offset(-15)
        }
        
        self.settingButton = WLYVerticalLayoutButton(type: .Custom)
        self.addSubview(self.settingButton)
        self.settingButton.setImage(UIImage(named: "Menu_Icon_Setting"), forState: .Normal)
        self.settingButton.setTitleColor(UIColor.wly_darkTextColor, forState: .Normal)
        self.settingButton.titleLabel?.font = UIFont.systemFontOfSize(10)
        self.settingButton.setTitle("设置", forState: .Normal)
        self.settingButton.snp_makeConstraints { (make) in
            make.top.bottom.equalTo(self.messageButton)
            make.width.equalTo(self.messageButton)
            make.left.equalTo(self.messageButton.snp_right).offset(15)
        }
    }
}
