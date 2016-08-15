//
//  WLYArticleNavigationBar.swift
//  zhihuSwiftDemo
//
//  Created by Afluy on 16/7/30.
//  Copyright © 2016年 helios. All rights reserved.
//

import UIKit

class WLYArticleNavigationBar: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        loadContentView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var leftView: UIImageView?
    var titleLabel: UILabel?
    
    var title: String? {
        get {
            return self.titleLabel?.text
        }
        
        set {
            self.titleLabel?.text = newValue
        }
    }
    
    func loadContentView() {
        self.backgroundColor = UIColor.blueColor()
        
        self.leftView = UIImageView()
        self.leftView?.backgroundColor = UIColor.redColor()
        self.addSubview(self.leftView!)
        self.leftView?.snp_makeConstraints(closure: { (make) in
            make.left.equalTo(self).offset(10)
            make.centerY.equalTo(self)
            make.width.height.equalTo(44)
        })
        
        self.titleLabel = UILabel()
        self.titleLabel?.text = "title"
        self.addSubview(self.titleLabel!)
        self.titleLabel?.snp_makeConstraints(closure: { (make) in
            make.center.equalTo(self)
        })
    }

}
