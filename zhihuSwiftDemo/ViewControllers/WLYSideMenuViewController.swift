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
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.scrollView.setContentOffset(CGPoint(x: 0.5 * self.scrollView.wly_width, y: 0), animated: false)
    }
    
    func setupView() {
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.scrollView = UIScrollView()
        self.view.addSubview(self.scrollView)
        self.scrollView.delegate = self
        self.scrollView.showsVerticalScrollIndicator = false
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.isPagingEnabled = true
        self.scrollView.bounces = false
        self.scrollView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(scrollToMainView))
        tapRecognizer.delegate = self
        self.scrollView.addGestureRecognizer(tapRecognizer)
        
        self.scrollView.contentSize = CGSize(width: self.view.wly_width * 1.5, height: self.view.wly_height)
        
        self.scrollContentView = UIView()
        self.scrollView.addSubview( self.scrollContentView)
        self.scrollContentView.snp.makeConstraints { (make) in
            make.left.top.equalTo(self.scrollView)
            make.height.equalTo(self.scrollView)
            make.width.equalTo(self.scrollView).multipliedBy(1.5)
        }
        
        self.addChildViewController(self.leftViewController)
        self.scrollContentView.addSubview(self.leftViewController.view)
        self.leftViewController.view.snp.makeConstraints { (make) in
            make.left.top.bottom.equalTo( self.scrollContentView)
            make.width.equalTo(self.scrollContentView).dividedBy(3)
        }
        
        self.addMainViewController(self.mainViewController)
    }
    
    func addMainViewController(_ vc: UIViewController) {
        self.addChildViewController(vc)
        self.scrollContentView.addSubview(vc.view)
        vc.view.snp.remakeConstraints { (make) in
            make.top.bottom.right.equalTo(self.scrollContentView)
            make.width.equalTo(self.scrollContentView).multipliedBy(2/3.0)
        }
    }
    
    func bindObserver() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(scrollToLeftView),
                                               name: NSNotification.Name(rawValue: WLYSideMenuViewController.WLYNoticationNameShowMenuView),
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(scrollToMainView),
                                               name: NSNotification.Name(rawValue: WLYSideMenuViewController.WLYNoticationNameHideMenuView),
                                               object: nil)
    }
    
    func removeObserver() {
        NotificationCenter.default.removeObserver(self)
    }
    
    func scrollToLeftView() {
        self.scrollView.setContentOffset(CGPoint.zero, animated: true)
    }
    
    func scrollToMainView() {
        self.scrollView.setContentOffset(CGPoint(x: 0.5 * self.scrollView.wly_width, y: 0), animated: true)
    }
    
    func showViewController(_ vc: UIViewController) {
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
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        let shouldReceiveTouch = self.scrollView.contentOffset.x == 0 && (touch.location(in: self.scrollView).x >= self.scrollView.wly_width / 2)
        WLYLog.d("shouldReceiveTouch: \(shouldReceiveTouch)")
        return shouldReceiveTouch
    }

}
