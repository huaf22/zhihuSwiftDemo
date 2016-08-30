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
    
    private var pull: Bool = true
    
    var state: PullToRefreshState = .Pulling {
        didSet {
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
            if !self.pull {
                return
            }
//            print(offsetY)
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
            if upHeight > triggerRefreshHeigh {
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
    
    func scrollViewDidPull() {
        
    }
    
    func scrollViewDidTrigger() {
    
    }
    
    func scrollViewDidRefresh() {
        scrollViewInsets = self.tableView.contentInset
        
        var insets = self.tableView.contentInset
        if pull {
            insets.top += triggerRefreshHeigh
        } else {
            insets.bottom += triggerRefreshHeigh
        }
//        self.tableView.bounces = false
    }
    
    func scrollViewDidStopRefresh() {
        self.state = .Pulling
//        self.tableView.bounces = true
    }
}