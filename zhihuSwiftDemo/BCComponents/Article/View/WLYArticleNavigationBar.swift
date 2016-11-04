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
    
    var backgroundView: UIView!
    
    var leftButton: UIButton!
    var titleLabel: UILabel!
    var rightButton: UIButton!
    
    var refreshImageView: WLYRefreshLoadingView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var title: String? {
        get {
            return self.titleLabel?.text
        }
        
        set {
            self.titleLabel?.text = newValue
        }
    }
    
    override var alpha: CGFloat {
        
        get {
            return self.backgroundView.alpha
        }
        
        set {
            self.backgroundView.alpha = newValue
        }
    }
    
    func setupView() {
        self.backgroundColor = UIColor.clear
        
        self.backgroundView = UIView()
        self.addSubview(self.backgroundView)
        self.backgroundView.backgroundColor = UIColor(rgba: "#028fd6")
        self.backgroundView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        
        self.leftButton = UIButton(type: .custom)
        self.addSubview(self.leftButton)
        self.leftButton.setImage(UIImage.init(named: "Home_Icon_Menu_G"), for: UIControlState())
        self.leftButton.setImage(UIImage.init(named: "Home_Icon_Menu_G_Highlight"), for: .highlighted)
        self.leftButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(self)
            make.left.equalTo(self)
            make.height.equalTo(ButtonHeight)
            make.width.equalTo(ButtonWidth)
        }
        
        self.titleLabel = UILabel()
        self.addSubview(self.titleLabel)
        self.titleLabel.text = "今日新闻"
        self.titleLabel.textColor = UIColor.white
        self.titleLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(self)
            make.centerX.equalTo(self)
            make.height.equalTo(ButtonHeight)
        }
        
//        self.rightButton = UIButton(type: .Custom)
//        self.addSubview(self.rightButton)
//        self.rightButton.setImage(UIImage.init(named: "Dark_Management_Add"), forState: .Normal)
//        self.rightButton.setImage(UIImage.init(named: "Dark_Management_Add"), forState: .Highlighted)
//        self.rightButton.snp.makeConstraints { (make) in
//            make.bottom.equalTo(self)
//            make.right.equalTo(self)
//            make.height.equalTo(ButtonHeight)
//            make.width.equalTo(ButtonWidth)
//        }
        
        self.refreshImageView = WLYRefreshLoadingView()
        self.refreshImageView.backgroundColor = UIColor.clear
        self.addSubview(self.refreshImageView)
        self.refreshImageView.snp.makeConstraints { (make) in
            make.height.width.equalTo(ButtonHeight)
            make.bottom.equalTo(self)
            make.right.equalTo(self.titleLabel.snp.left).offset(-5)
        }
    }
    
    func showPullProgress(_ ratio: CGFloat) {
        print("WLYArticleNavigationBar showPullProgress")
        self.refreshImageView.showPullProgress(ratio)
    }
    
    func startLoading() {
        print("WLYArticleNavigationBar startLoading")
        self.refreshImageView.startLoading()
    }
    
    func stopLoading() {
        print("WLYArticleNavigationBar stopLoading")
        self.refreshImageView.stopLoading()
    }
}
