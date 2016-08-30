//
//  WLYPullToRefreshView.swift
//  zhihuSwiftDemo
//
//  Created by Afluy on 16/8/30.
//  Copyright © 2016年 helios. All rights reserved.
//

import Foundation
import UIKit

public class WLYPullToRefreshView: UIView {
    enum PullToRefreshState {
        case Pulling
        case Triggered
        case Refreshing
        case Stop
    }
    
    // MARK: Variables
    let contentOffsetKeyPath = "contentOffset"
    let contentSizeKeyPath = "contentSize"
    var kvoContext = "PullToRefreshKVOContext"
    
    var refreshAutoStopTime: Double = 10
    var refreshStopTime: Double = 0.2
    
    var scrollViewBounces: Bool = true
    var scrollViewInsets: UIEdgeInsets = UIEdgeInsetsZero
    var refreshCompletion: (Void -> Void)?
    
    private var pull: Bool = true
    
    private var positionY:CGFloat = 0 {
        didSet {
            if self.positionY == oldValue {
                return
            }
            var frame = self.frame
            frame.origin.y = positionY
            self.frame = frame
        }
    }
    
    var state: PullToRefreshState = PullToRefreshState.Pulling {
        didSet {
           
            if self.state == oldValue {
                return
            }
            guard let scrollView = superview as? UIScrollView else {
                return
            }
            
            print("WLYPullToRefreshView state: \(state)")
            switch self.state {
            case .Stop:
                stopRefreshAction(scrollView)
            case .Refreshing:
                startRefreshAction(scrollView)
            case .Pulling:
                startPullAction(scrollView)
            case .Triggered:
                startPullTriggeredAction(scrollView)
            }
        }
    }
    
    // MARK: UIView
    override convenience init(frame: CGRect) {
        self.init(frame:frame, refreshCompletion:nil)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        self.removeRegister()
    }
    
    init(frame: CGRect, down:Bool=true, refreshCompletion :(Void -> Void)?) {
        self.refreshCompletion = refreshCompletion
    
        self.pull = down
        
        super.init(frame: frame)
        self.autoresizingMask = .FlexibleWidth
    }
    
    public override func willMoveToSuperview(superView: UIView!) {
        //superview NOT superView, DO NEED to call the following method
        //superview dealloc will call into this when my own dealloc run later!!
        self.removeRegister()
        guard let scrollView = superView as? UIScrollView else {
            return
        }
        scrollView.addObserver(self, forKeyPath: contentOffsetKeyPath, options: .Initial, context: &kvoContext)
        if !pull {
            scrollView.addObserver(self, forKeyPath: contentSizeKeyPath, options: .Initial, context: &kvoContext)
        }
    }
    
    private func removeRegister() {
        if let scrollView = superview as? UIScrollView {
            scrollView.removeObserver(self, forKeyPath: contentOffsetKeyPath, context: &kvoContext)
            if !pull {
                scrollView.removeObserver(self, forKeyPath: contentSizeKeyPath, context: &kvoContext)
            }
        }
    }
    

    // MARK: KVO
   public  override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<()>) {
        guard let scrollView = object as? UIScrollView else {
            return
        }
        if keyPath == contentSizeKeyPath {
            self.positionY = scrollView.contentSize.height
            return
        }
        
        if !(context == &kvoContext && keyPath == contentOffsetKeyPath) {
            super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
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
                if scrollView.dragging == false && self.state != .Refreshing { //release the finger
                    self.state = .Refreshing //startAnimating
                } else if self.state != .Refreshing { //reach the threshold
                    self.state = .Triggered
                }
            } else if self.state == .Triggered {
                //starting point, start from pulling
                self.state = .Pulling
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
                if scrollView.dragging == false && self.state != .Refreshing { //release the finger
                    self.state = .Refreshing //startAnimating
                } else if self.state != .Refreshing { //reach the threshold
                    self.state = .Triggered
                }
            } else if self.state == .Triggered  {
                //starting point, start from pulling
                self.state = .Pulling
            }
        }
    }
    
    /**
     开始下拉
     */
    func startPullAction(scrollView: UIScrollView) {
        
    }
    
    /**
     下拉到临界点
     */
    func startPullTriggeredAction(scrollView: UIScrollView) {
        
    }
    
    /**
     用户松手,开始刷新操作
     */
    func startRefreshAction(scrollView: UIScrollView) {
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
//        UIView.animateWithDuration(0.5,
//                                   delay: 0,
//                                   options:[],
//                                   animations: { scrollView.contentInset = self.scrollViewInsets },
//                                   completion: { _ in
//                                    let time = dispatch_time(DISPATCH_TIME_NOW, Int64(self.refreshAutoStopTime * Double(NSEC_PER_SEC)))
//                                    dispatch_after(time, dispatch_get_main_queue()) {
//                                        self.state = .Stop
//                                    }
//                                    self.refreshCompletion?()
//        })
    }
    
    /**
     刷新完毕
     */
    func stopRefreshAction(scrollView: UIScrollView) {
        scrollView.bounces = self.scrollViewBounces
        scrollView.contentInset = self.scrollViewInsets
        self.state = .Pulling
        
//        UIView.animateWithDuration(self.refreshStopTime,
//                                   animations: {
//                                    scrollView.contentInset = self.scrollViewInsets
//            }
//        ) { _ in
//            self.state = .Pulling
//        }
    }
}