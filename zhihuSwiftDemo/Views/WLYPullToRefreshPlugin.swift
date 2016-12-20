//
//  WLYPullToRefreshPlugin.swift
//  zhihuSwiftDemo
//
//  Created by Afluy on 19/12/2016.
//  Copyright © 2016 helios. All rights reserved.
//

import Foundation
import UIKit

protocol WLYPullToRefreshPluginDelegate {
    
    func pullToRefreshScrollViewDidPull(scrollView: UIScrollView);
    func pullToRefreshScrollViewDidTrigger(scrollView: UIScrollView);
    func pullToRefreshScrollViewDidStopRefresh(scrollView: UIScrollView);
    
    func pullToRefreshScrollViewDidScroll(scrollView: UIScrollView);
    
}

class WLYPullToRefreshPlugin: NSObject {
    // MARK: Variables
    private let ContentOffsetKeyPath = "contentOffset"
    private let ContentSizeKeyPath = "contentSize"
    private var KVOContext = "PullToRefreshKVOContext"
    
    var triggerRefreshHeigh: CGFloat = 50.0
    var delegate: WLYPullToRefreshPluginDelegate?
    
    private enum PullToRefreshState {
        case pulling
        case triggered
        case refreshing
        case stop
    }
    
    private var scrollView: UIScrollView!
    private var scrollViewInsets: UIEdgeInsets = UIEdgeInsets.zero
    
    private var state: PullToRefreshState = .pulling {
        didSet {
            if self.state == oldValue {
                return
            }
            
            WLYLog.d("state: \(state)")
            switch self.state {
            case .stop:
                self.scrollViewDidStopRefresh()
            case .refreshing:
                self.scrollViewDidRefresh()
            case .pulling:
                self.scrollViewDidPull()
            case .triggered:
                self.scrollViewDidTrigger()
            }
        }
    }
    
    init(_ scrollView: UIScrollView) {
        super.init()
        
        self.scrollView = scrollView
        self.addObserver()
    }
    
    deinit {
        self.removeObserver()
    }
    
    // MARK:- Private Methods
    
    func pullToRefreshEnd(result success: Bool) {
        self.scrollViewDidStopRefresh()
    }
    
    // MARK:- Public Methods
    
    private func addObserver() {
        self.scrollView.addObserver(self, forKeyPath: ContentOffsetKeyPath, options: .initial, context: &KVOContext)
//      self.scrollView.addObserver(self, forKeyPath: ContentSizeKeyPath, options: .initial, context: &KVOContext)
    }
    
    private func removeObserver() {
        self.scrollView.removeObserver(self, forKeyPath: ContentOffsetKeyPath, context: &KVOContext)
//      self.scrollView.removeObserver(self, forKeyPath: ContentSizeKeyPath, context: &KVOContext)
    }
    
    private func scrollViewDidRefresh() {
        scrollViewInsets = self.scrollView.contentInset
        
        var insets = self.scrollView.contentInset
        insets.top += self.triggerRefreshHeigh
        
        //self.tableView.bounces = false
    }
    
    private func scrollViewDidStopRefresh() {
        self.state = .pulling
        //self.tableView.bounces = true
    }
    
    private func scrollViewDidPull() {
        if let delegate = self.delegate {
            delegate.pullToRefreshScrollViewDidPull(scrollView: scrollView)
        }
    }
    
    private func scrollViewDidTrigger() {
        if let delegate = self.delegate {
            delegate.pullToRefreshScrollViewDidTrigger(scrollView: scrollView)
        }
    }
    
    // MARK:- KVO
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if (context == &KVOContext && keyPath == ContentOffsetKeyPath) {
//            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
            
            let offsetY = scrollView.contentOffset.y
            
            if offsetY <= -self.scrollView.contentInset.top {
                if offsetY < -self.scrollView.contentInset.top - self.triggerRefreshHeigh {
                    if scrollView.isDragging == false && self.state != .refreshing { //release the finger
                        self.state = .refreshing          //startAnimating
                    } else if self.state != .refreshing { //reach the threshold
                        self.state = .triggered
                    }
                } else if self.state == .triggered {
                    //starting point, start from pulling
                    self.state = .pulling
                }
                
                if self.state == .pulling {
                    self.scrollViewDidPull()
                }
            }
            
            if let delegate = self.delegate {
                delegate.pullToRefreshScrollViewDidScroll(scrollView: scrollView)
            }
            return
        }
    }
    
}
