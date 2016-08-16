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
    
    enum WLYTableViewLoadingStatus {
        case Normal
        case Pulling
        case Refreshing
    }
    
    private var loadingStatus: WLYTableViewLoadingStatus = .Normal
    var triggerRefreshHeigh: CGFloat = 0
    
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView = UITableView(frame: CGRectZero, style: UITableViewStyle.Plain)
        self.view.addSubview(tableView)
        self.tableView.delegate = self;
        self.tableView.snp_makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y
        
        if y < -scrollView.contentInset.top {  //
            if scrollView.dragging {
                if self.loadingStatus == .Normal {
                    self.loadingStatus = .Pulling
                } else if self.loadingStatus == .Pulling && y <= (-scrollView.contentInset.top - triggerRefreshHeigh) {
                    self.loadingStatus = .Refreshing
                    self.didRefreshing()
                }
            }
        }
        
        if self.loadingStatus == .Pulling {
            self.didPulling()
        }

    }
    
    func didPulling() {
        print("WLYTableViewController didPulling")
    }
    
    func didRefreshing() {
        print("WLYTableViewController didRefreshing")
//        NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: #selector(stopRefresh), userInfo: nil, repeats: false)
    }
    
    func stopRefresh() {
        print("WLYTableViewController stopRefresh")
        self.loadingStatus = .Normal
    }
}