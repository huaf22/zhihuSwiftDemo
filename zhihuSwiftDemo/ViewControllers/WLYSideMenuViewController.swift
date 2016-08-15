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
    
    var leftMenuView: UIView!
    var middleView: UIView!
    
    var currentChildVC: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadContentViews()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.scrollView.setContentOffset(CGPointMake(0.5 * self.scrollView.wly_width(), 0), animated: false)
    }
    
    func loadContentViews() {
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.scrollView = UIScrollView()
        self.scrollView.delegate = self
        self.scrollView.showsVerticalScrollIndicator = false
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.pagingEnabled = true
        self.scrollView.bounces = false
        self.view.addSubview(self.scrollView)
        self.scrollView.snp_makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
        self.scrollView.contentSize = CGSizeMake(self.view.wly_width() * 1.5, self.view.wly_height())
        
        let contentView = UIView()
        contentView.backgroundColor = UIColor.blueColor()
        self.scrollView.addSubview(contentView)
        contentView.snp_makeConstraints { (make) in
            make.left.top.equalTo(self.scrollView)
            make.height.equalTo(self.scrollView)
            make.width.equalTo(self.scrollView).multipliedBy(1.5)
        }
        
        contentView.addSubview(self.leftMenuView!)
        self.leftMenuView?.snp_makeConstraints { (make) in
            make.left.top.bottom.equalTo(contentView)
            make.width.equalTo(contentView).dividedBy(3)
        }
        
        self.middleView = UIView()
        contentView.addSubview(self.middleView)
        self.middleView.snp_makeConstraints { (make) in
            make.left.equalTo(self.leftMenuView.snp_right)
            make.top.bottom.right.equalTo(contentView)
        }
    }
    
    func showViewController(vc: UIViewController) {
        for viewController in self.childViewControllers {
            viewController.removeFromParentViewController()
        }
        for view in self.middleView.subviews {
            view.removeFromSuperview()
        }
        
        self.addChildViewController(vc)
        self.middleView.addSubview(vc.view)
        vc.view.snp_makeConstraints { (make) in
            make.edges.equalTo(self.middleView)
        }
        
        self.currentChildVC = vc
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
    }
}
