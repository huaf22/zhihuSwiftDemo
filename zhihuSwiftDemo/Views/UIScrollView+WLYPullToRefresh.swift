//
//  UIScrollView+WLYPullToRefresh.swift
//  zhihuSwiftDemo
//
//  Created by Afluy on 16/8/30.
//  Copyright © 2016年 helios. All rights reserved.
//

import Foundation
import UIKit

extension UIScrollView {
    
    // MARK: Add Methods
    public func addPullRefreshView(_ view: UIView) {
        let refreshViewFrame = CGRect(x: 0, y: -view.wly_height, width: self.frame.size.width, height: view.wly_height)
        view.frame = refreshViewFrame
        view.tag = 50001
        addSubview(view)
    }
    
    public func addPushRefreshView(_ view: UIView) {
        let refreshViewFrame = CGRect(x: 0, y: contentSize.height, width: self.frame.size.width, height: view.wly_height)
        view.frame = refreshViewFrame
        view.tag = 50002
        addSubview(view)
    }
    
    fileprivate func refreshViewWithTag(_ tag:Int) -> WLYPullToRefreshView? {
        let pullToRefreshView = viewWithTag(tag)
        return pullToRefreshView as? WLYPullToRefreshView
    }
    
    public func startPullRefresh() {
        let refreshView = self.refreshViewWithTag(50001)
        refreshView?.state = .refreshing
    }
    
    public func stopPullRefresh() {
        let refreshView = self.refreshViewWithTag(50001)
        refreshView?.state = .stop
    }
    
    public func removePullRefresh() {
        let refreshView = self.refreshViewWithTag(50001)
        refreshView?.removeFromSuperview()
    }
    
    public func startPushRefresh() {
        let refreshView = self.refreshViewWithTag(50002)
        refreshView?.state = .refreshing
    }
    
    public func stopPushRefresh() {
        let refreshView = self.refreshViewWithTag(50002)
       
        refreshView?.state = .stop
    }
    
    public func removePushRefresh() {
        let refreshView = self.refreshViewWithTag(50002)
        refreshView?.removeFromSuperview()
    }
    
//    // If you want to PullToRefreshView fixed top potision, Please call this function in scrollViewDidScroll
//    public func fixedPullToRefreshViewForDidScroll() {
//        let pullToRefreshView = self.refreshViewWithTag(PullToRefreshConst.pullTag)
//        if !PullToRefreshConst.fixedTop || pullToRefreshView == nil {
//            return
//        }
//        var frame = pullToRefreshView!.frame
//        if self.contentOffset.y < -PullToRefreshConst.height {
//            frame.origin.y = self.contentOffset.y
//            pullToRefreshView!.frame = frame
//        }
//        else {
//            frame.origin.y = -PullToRefreshConst.height
//            pullToRefreshView!.frame = frame
//        }
//    }

}
