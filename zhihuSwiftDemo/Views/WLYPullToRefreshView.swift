//
//  WLYPullToRefreshView.swift
//  zhihuSwiftDemo
//
//  Created by Afluy on 16/8/30.
//  Copyright © 2016年 helios. All rights reserved.
//

import Foundation
import UIKit

open class WLYPullToRefreshView: UIView {
    enum PullToRefreshState {
        case pulling
        case triggered
        case refreshing
        case stop
    }
    
    // MARK: Variables
    let contentOffsetKeyPath = "contentOffset"
    let contentSizeKeyPath = "contentSize"
    var kvoContext = "PullToRefreshKVOContext"
    
    var refreshAutoStopTime: Double = 10
    var refreshStopTime: Double = 0.2
    
    var scrollViewBounces: Bool = true
    var scrollViewInsets: UIEdgeInsets = UIEdgeInsets.zero
    var refreshCompletion: ((Void) -> Void)?
    
    fileprivate var pull: Bool = true
    
    fileprivate var positionY: CGFloat = 0 {
        didSet {
            if self.positionY == oldValue {
                return
            }
            var frame = self.frame
            frame.origin.y = positionY
            self.frame = frame
        }
    }
    
    var state: PullToRefreshState = PullToRefreshState.pulling {
        didSet {
           
            if self.state == oldValue {
                return
            }
            guard let scrollView = superview as? UIScrollView else {
                return
            }
            
            print("WLYPullToRefreshView state: \(state)")
            switch self.state {
            case .stop:
                stopRefreshAction(scrollView)
            case .refreshing:
                startRefreshAction(scrollView)
            case .pulling:
                startPullAction(scrollView)
            case .triggered:
                startPullTriggeredAction(scrollView)
            }
        }
    }
    
    // MARK: UIView
    override convenience init(frame: CGRect) {
        self.init(frame:frame, refreshCompletion:nil)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    deinit {
        self.removeRegister()
    }
    
    init(frame: CGRect, down:Bool=true, refreshCompletion :((Void) -> Void)?) {
        self.refreshCompletion = refreshCompletion
    
        self.pull = down
        
        super.init(frame: frame)
        self.autoresizingMask = .flexibleWidth
    }
    
    open override func willMove(toSuperview superView: UIView!) {
        //superview NOT superView, DO NEED to call the following method
        //superview dealloc will call into this when my own dealloc run later!!
        self.removeRegister()
        guard let scrollView = superView as? UIScrollView else {
            return
        }
        scrollView.addObserver(self, forKeyPath: contentOffsetKeyPath, options: .initial, context: &kvoContext)
        if !pull {
            scrollView.addObserver(self, forKeyPath: contentSizeKeyPath, options: .initial, context: &kvoContext)
        }
    }
    
    fileprivate func removeRegister() {
        if let scrollView = superview as? UIScrollView {
            scrollView.removeObserver(self, forKeyPath: contentOffsetKeyPath, context: &kvoContext)
            if !pull {
                scrollView.removeObserver(self, forKeyPath: contentSizeKeyPath, context: &kvoContext)
            }
        }
    }
    

    // MARK: KVO
   open  override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard let scrollView = object as? UIScrollView else {
            return
        }
        if keyPath == contentSizeKeyPath {
            self.positionY = scrollView.contentSize.height
            return
        }
        
        if !(context == &kvoContext && keyPath == contentOffsetKeyPath) {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
            return
        }
        
        // Pulling State Check
        let offsetY = scrollView.contentOffset.y
        
        if offsetY <= 0 {
            if !self.pull {
                return
            }

            if offsetY < -self.frame.size.height {
                // pulling or refreshing
                if scrollView.isDragging == false && self.state != .refreshing { //release the finger
                    self.state = .refreshing //startAnimating
                } else if self.state != .refreshing { //reach the threshold
                    self.state = .triggered
                }
            } else if self.state == .triggered {
                //starting point, start from pulling
                self.state = .pulling
            }
            return //return for pull down
        }
        
        //push up
        let upHeight = offsetY + scrollView.frame.size.height - scrollView.contentSize.height
        if upHeight > 0 {
            // pulling or refreshing
            if self.pull {
                return
            }
            if upHeight > self.frame.size.height {
                // pulling or refreshing
                if scrollView.isDragging == false && self.state != .refreshing { //release the finger
                    self.state = .refreshing //startAnimating
                } else if self.state != .refreshing { //reach the threshold
                    self.state = .triggered
                }
            } else if self.state == .triggered  {
                //starting point, start from pulling
                self.state = .pulling
            }
        }
    }
    
    /**
     开始下拉
     */
    func startPullAction(_ scrollView: UIScrollView) {
        
    }
    
    /**
     下拉到临界点
     */
    func startPullTriggeredAction(_ scrollView: UIScrollView) {
        
    }
    
    /**
     用户松手,开始刷新操作
     */
    func startRefreshAction(_ scrollView: UIScrollView) {
        self.scrollViewBounces = scrollView.bounces
        self.scrollViewInsets = scrollView.contentInset
        
        var insets = scrollView.contentInset
        if self.pull {
            insets.top += self.frame.size.height
        } else {
            insets.bottom += self.frame.size.height
        }
        scrollView.bounces = false
        
        scrollView.contentInset = self.scrollViewInsets
        
        self.refreshCompletion?()
    }
    
    /**
     刷新完毕
     */
    func stopRefreshAction(_ scrollView: UIScrollView) {
        scrollView.bounces = self.scrollViewBounces
        scrollView.contentInset = self.scrollViewInsets
        self.state = .pulling
    }
}
