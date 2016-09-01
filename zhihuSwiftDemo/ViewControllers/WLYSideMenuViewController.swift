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
    var scrollContentView: UIView!
    
    var leftViewController: UIViewController!
    var mainViewController: UIViewController!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience init(leftViewController: UIViewController, mainViewController: UIViewController) {
        self.init()
        
        self.leftViewController = leftViewController
        self.mainViewController = mainViewController
    }
    
    deinit {
        self.removeObserver()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupView()
        self.bindObserver()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.scrollView.setContentOffset(CGPointMake(0.5 * self.scrollView.wly_width, 0), animated: false)
    }
    
    func setupView() {
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.scrollView = UIScrollView()
        self.view.addSubview(self.scrollView)
        self.scrollView.delegate = self
        self.scrollView.showsVerticalScrollIndicator = false
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.pagingEnabled = true
        self.scrollView.bounces = false
        self.scrollView.snp_makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(scrollToMainView))
        tapRecognizer.delegate = self
        self.scrollView.addGestureRecognizer(tapRecognizer)
        
        self.scrollView.contentSize = CGSizeMake(self.view.wly_width * 1.5, self.view.wly_height)
        
        self.scrollContentView = UIView()
        self.scrollView.addSubview( self.scrollContentView)
        self.scrollContentView.snp_makeConstraints { (make) in
            make.left.top.equalTo(self.scrollView)
            make.height.equalTo(self.scrollView)
            make.width.equalTo(self.scrollView).multipliedBy(1.5)
        }
        
        self.addChildViewController(self.leftViewController)
        self.scrollContentView.addSubview(self.leftViewController.view)
        self.leftViewController.view.snp_makeConstraints { (make) in
            make.left.top.bottom.equalTo( self.scrollContentView)
            make.width.equalTo(self.scrollContentView).dividedBy(3)
        }
        
        self.addMainViewController(self.mainViewController)
    }
    
    func addMainViewController(vc: UIViewController) {
        self.addChildViewController(vc)
        self.scrollContentView.addSubview(vc.view)
        vc.view.snp_remakeConstraints { (make) in
            make.top.bottom.right.equalTo(self.scrollContentView)
            make.width.equalTo(self.scrollContentView).multipliedBy(2/3.0)
        }
    }
    
    func bindObserver() {
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: #selector(scrollToLeftView),
                                                         name: WLYSideMenuViewController.WLYNoticationNameShowMenuView,
                                                         object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: #selector(scrollToMainView),
                                                         name: WLYSideMenuViewController.WLYNoticationNameHideMenuView,
                                                         object: nil)
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
    

    
    func showViewController(vc: UIViewController) {
        if self.mainViewController != nil {
            if vc == self.mainViewController {
                return
            } else {
                self.mainViewController.removeFromParentViewController()
                self.mainViewController.view.removeFromSuperview()
            }
        }
        
        self.addMainViewController(vc)
        self.mainViewController = vc
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        let shouldReceiveTouch = self.scrollView.contentOffset.x == 0 && (touch.locationInView(self.scrollView).x >= self.scrollView.wly_width / 2)
        WLYLog.d("shouldReceiveTouch: \(shouldReceiveTouch)")
        return shouldReceiveTouch
    }

}
