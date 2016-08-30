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
        case Pulling
        case Triggered
        case Refreshing
        case Stop
    }
    
    var tableView: UITableView!
    
    var triggerRefreshHeigh: CGFloat = 0
    private var scrollViewInsets: UIEdgeInsets = UIEdgeInsetsZero
    
    var state: PullToRefreshState = .Pulling {

        didSet {
            if self.state == oldValue {
                return
            }
            
            WLYLog.w("state: \(state)")
            switch self.state {
            case .Stop:
                self.scrollViewDidStopRefresh()
            case .Refreshing:
                self.scrollViewDidRefresh()
            case .Pulling:
                self.scrollViewDidPull()
            case .Triggered:
                self.scrollViewDidTrigger()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView = UITableView(frame: CGRectZero, style: UITableViewStyle.Plain)
        self.tableView.delegate = self
        self.view.addSubview(tableView)
    }
    

    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        
        if offsetY <= -self.tableView.contentInset.top {
            if offsetY < -self.tableView.contentInset.top - triggerRefreshHeigh {
                if scrollView.dragging == false && self.state != .Refreshing { //release the finger
                    self.state = .Refreshing          //startAnimating
                } else if self.state != .Refreshing { //reach the threshold
                    self.state = .Triggered
                }
            } else if self.state == .Triggered {
                //starting point, start from pulling
                self.state = .Pulling
            }
            
            if self.state == .Pulling {
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
        self.state = .Pulling
//        self.tableView.bounces = true
    }
}