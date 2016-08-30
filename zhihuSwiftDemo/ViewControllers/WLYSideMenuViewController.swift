//
//  WLYSideMenuViewController.swift
//  zhihuSwiftDemo
//
//  Created by Afluy on 16/8/10.
//  Copyright © 2016年 helios. All rights reserved.
//

import Foundation
import UIKit

class WLYSideMenuViewController: WLYViewController, UIScrollViewDelegate, UIGestureRecognizerDelegate {
    
    static let WLYNoticationNameShowMenuView = "WLYNoticationNameShowMenuView"
    static let WLYNoticationNameHideMenuView = "WLYNoticationNameHideMenuView"
    
    var scrollView: UIScrollView!
    
    var leftView: UIView!
    var mainView: UIView!
    
    var currentChildVC: UIViewController?
    
    deinit {
        self.removeObserver()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadContentViews()
        self.bindObserver()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.scrollView.setContentOffset(CGPointMake(0.5 * self.scrollView.wly_width, 0), animated: false)
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
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(scrollToMainView))
        tapRecognizer.delegate = self
        self.scrollView.addGestureRecognizer(tapRecognizer)
        
        self.scrollView.contentSize = CGSizeMake(self.view.wly_width * 1.5, self.view.wly_height)
        
        let contentView = UIView()
        self.scrollView.addSubview(contentView)
        contentView.snp_makeConstraints { (make) in
            make.left.top.equalTo(self.scrollView)
            make.height.equalTo(self.scrollView)
            make.width.equalTo(self.scrollView).multipliedBy(1.5)
        }
        
        
        self.leftView = UIView()
        contentView.addSubview(self.leftView!)
        self.leftView?.snp_makeConstraints { (make) in
            make.left.top.bottom.equalTo(contentView)
            make.width.equalTo(contentView).dividedBy(3)
        }
        
        self.mainView = UIView()
        contentView.addSubview(self.mainView)
        self.mainView.snp_makeConstraints { (make) in
            make.left.equalTo(self.leftView.snp_right)
            make.top.bottom.right.equalTo(contentView)
        }
    }
    
    func bindObserver() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(scrollToLeftView), name: WLYSideMenuViewController.WLYNoticationNameShowMenuView, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(scrollToMainView), name: WLYSideMenuViewController.WLYNoticationNameHideMenuView, object: nil)
    }
    
    func removeObserver() {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func scrollToLeftView() {
        self.scrollView.setContentOffset(CGPointZero, animated: true)
    }
    
    func scrollToMainView() {
        self.scrollView.setContentOffset(CGPointMake(0.5 * self.scrollView.wly_width, 0), animated: true)
    }
    
    func showLeftView(view: UIView) {
        for subView in self.leftView.subviews {
            subView.removeFromSuperview()
        }
        
        self.leftView.addSubview(view)
        view.snp_makeConstraints { (make) in
            make.edges.equalTo(self.leftView)
        }
    }
    
    func showViewController(vc: UIViewController) {
        for viewController in self.childViewControllers {
            viewController.removeFromParentViewController()
        }
        for view in self.mainView.subviews {
            view.removeFromSuperview()
        }
        
        self.addChildViewController(vc)
        
        self.mainView.addSubview(vc.view)
        vc.view.snp_makeConstraints { (make) in
            make.edges.equalTo(self.mainView)
        }
        
        self.currentChildVC = vc
    }
    
//    func scrollViewDidScroll(scrollView: UIScrollView) {
//        if self.scrollView.contentOffset.x == 0 {
//            self.mainView.userInteractionEnabled = false
//        } else {
//            self.mainView.userInteractionEnabled = true
//        }
//    }
//    
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        let shouldReceiveTouch = self.scrollView.contentOffset.x == 0 && (touch.locationInView(self.scrollView).x >= self.scrollView.wly_width / 2)
        WLYLog.d("shouldReceiveTouch: \(shouldReceiveTouch)")
        return shouldReceiveTouch
    }

}
