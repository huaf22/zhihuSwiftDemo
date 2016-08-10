//
//  WLYSideMenuViewController.swift
//  zhihuSwiftDemo
//
//  Created by Afluy on 16/8/10.
//  Copyright © 2016年 helios. All rights reserved.
//

import Foundation
import UIKit

class WLYSideMenuViewController: WLYViewController , UIScrollViewDelegate {
    var scrollView: UIScrollView!
    
    var leftMenuView: UIView?
    var mainViewController: UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadContentViews()
    }
    
    func loadContentViews() {
        self.scrollView = UIScrollView()
        self.scrollView.delegate = self
        self.scrollView.showsVerticalScrollIndicator = false
        self.scrollView.showsVerticalScrollIndicator = false
        self.scrollView.scrollsToTop = false
        self.scrollView.pagingEnabled = true
        self.scrollView.bounces = false
        self.view.addSubview(self.scrollView)
        self.scrollView.snp_makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
        self.scrollView.contentSize = CGSizeMake(self.view.wly_width() * 1.5, self.view.wly_height())
        self.scrollView.backgroundColor = UIColor.redColor()
        
        let contentView = UIView()
        contentView.backgroundColor = UIColor.blueColor()
        self.scrollView.addSubview(contentView)
        
        contentView.snp_makeConstraints { (make) in
            make.edges.equalTo(self.scrollView)
            make.height.equalTo(self.scrollView)
            make.width.equalTo(self.scrollView).multipliedBy(1.5)
        }
        
        contentView.addSubview(self.leftMenuView!)
        self.leftMenuView?.snp_makeConstraints { (make) in
            make.left.top.bottom.equalTo(contentView)
            make.width.equalTo(contentView).dividedBy(3)
        }
        
        self.addChildViewController(self.mainViewController)
        contentView.addSubview(self.mainViewController.view)
        self.mainViewController.view.snp_makeConstraints { (make) in
            make.left.equalTo((self.leftMenuView?.snp_right)!)
            make.top.bottom.right.equalTo(contentView)
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
    }
}
