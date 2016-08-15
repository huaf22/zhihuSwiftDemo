//
//  WLYArticleNavigationBar.swift
//  zhihuSwiftDemo
//
//  Created by Afluy on 16/7/30.
//  Copyright © 2016年 helios. All rights reserved.
//

import UIKit

class WLYArticleNavigationBar: UIView {
    let ButtonMargin: CGFloat = 10
    let ButtonHeight: CGFloat = 38
    let ButtonWidth: CGFloat = 44
    
    var leftButton: UIButton!
    var titleLabel: UILabel!
    var rightButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        loadContentView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var title: String? {
        get {
            return self.titleLabel?.text
        }
        
        set {
            self.titleLabel?.text = newValue
        }
    }
    
    func loadContentView() {
        self.backgroundColor = UIColor.clearColor()
        
        self.leftButton = UIButton(type: .Custom)
        self.addSubview(self.leftButton)
        self.leftButton.setImage(UIImage.init(named: "Home_Icon_Menu_G"), forState: .Normal)
        self.leftButton.setImage(UIImage.init(named: "Home_Icon_Menu_G_Highlight"), forState: .Highlighted)
        self.leftButton.snp_makeConstraints { (make) in
            make.bottom.equalTo(self)
            make.left.equalTo(self)
            make.height.equalTo(ButtonHeight)
            make.width.equalTo(ButtonWidth)
        }
        
        self.titleLabel = UILabel()
        self.addSubview(self.titleLabel)
        self.titleLabel.text = "今日新闻"
        self.titleLabel.textColor = UIColor.whiteColor()
        self.titleLabel.snp_makeConstraints { (make) in
            make.bottom.equalTo(self)
            make.centerX.equalTo(self)
            make.height.equalTo(ButtonHeight)
        }
        
        self.rightButton = UIButton(type: .Custom)
        self.addSubview(self.rightButton)
        self.rightButton.setImage(UIImage.init(named: "Dark_Management_Add"), forState: .Normal)
        self.rightButton.setImage(UIImage.init(named: "Dark_Management_Add"), forState: .Highlighted)
        self.rightButton.snp_makeConstraints { (make) in
            make.bottom.equalTo(self)
            make.right.equalTo(self)
            make.height.equalTo(ButtonHeight)
            make.width.equalTo(ButtonWidth)
        }
    }

}
