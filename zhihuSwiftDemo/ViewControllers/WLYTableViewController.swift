//
//  WLYTableViewController.swift
//  zhihuSwiftDemo
//
//  Created by Afluy on 16/8/16.
//  Copyright © 2016年 helios. All rights reserved.
//

import Foundation
import UIKit

class WLYTableViewController: WLYViewController, UITableViewDelegate {
    enum PullToRefreshState {
        case pulling
        case triggered
        case refreshing
        case stop
    }
    
    var tableView: UITableView!
    
    var triggerRefreshHeigh: CGFloat = 0
    fileprivate var scrollViewInsets: UIEdgeInsets = UIEdgeInsets.zero
    
    var state: PullToRefreshState = .pulling {

        didSet {
            if self.state == oldValue {
                return
            }
            
            WLYLog.w("state: \(state)")
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView = UITableView(frame: CGRect.zero, style: UITableViewStyle.plain)
        self.tableView.delegate = self
        self.view.addSubview(tableView)
    }
    

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        
        if offsetY <= -self.tableView.contentInset.top {
            if offsetY < -self.tableView.contentInset.top - triggerRefreshHeigh {
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
    }
    
    func scrollViewDidPull() {
        
    }
    
    func scrollViewDidTrigger() {
    
    }
    
    func scrollViewDidRefresh() {
        scrollViewInsets = self.tableView.contentInset
        
        var insets = self.tableView.contentInset
        insets.top += triggerRefreshHeigh
      
//        self.tableView.bounces = false
    }
    
    func scrollViewDidStopRefresh() {
        self.state = .pulling
//        self.tableView.bounces = true
    }
}
