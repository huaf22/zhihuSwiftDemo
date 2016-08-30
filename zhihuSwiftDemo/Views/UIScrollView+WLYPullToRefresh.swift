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
    public func addPullRefreshView(view: UIView) {
        let refreshViewFrame = CGRectMake(0, -view.wly_height, self.frame.size.width, view.wly_height)
        view.frame = refreshViewFrame
        view.tag = 50001
        addSubview(view)
    }
    
    public func addPushRefreshView(view: UIView) {
        let refreshViewFrame = CGRectMake(0, contentSize.height, self.frame.size.width, view.wly_height)
        view.frame = refreshViewFrame
        view.tag = 50002
        addSubview(view)
    }
    
    private func refreshViewWithTag(tag:Int) -> WLYPullToRefreshView? {
        let pullToRefreshView = viewWithTag(tag)
        return pullToRefreshView as? WLYPullToRefreshView
    }
    
    public func startPullRefresh() {
        let refreshView = self.refreshViewWithTag(50001)
        refreshView?.state = .Refreshing
    }
    
    public func stopPullRefresh() {
        let refreshView = self.refreshViewWithTag(50001)
        refreshView?.state = .Stop
    }
    
    public func removePullRefresh() {
        let refreshView = self.refreshViewWithTag(50001)
        refreshView?.removeFromSuperview()
    }
    
    public func startPushRefresh() {
        let refreshView = self.refreshViewWithTag(50002)
        refreshView?.state = .Refreshing
    }
    
    public func stopPushRefresh() {
        let refreshView = self.refreshViewWithTag(50002)
       
        refreshView?.state = .Stop
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