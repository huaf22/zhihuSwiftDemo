//
//  WLYArticleChannelView.swift
//  zhihuSwiftDemo
//
//  Created by Afluy on 20/12/2016.
//  Copyright © 2016 helios. All rights reserved.
//

import Foundation
import  UIKit

class WLYArticleChannelView : UIView, WLYPullToRefreshPluginDelegate {
    private let BarViewHeight: CGFloat = 58
    private let TriggerRefreshHeigh: CGFloat = 50.0
    
    private var pullToRefreshPlugin: WLYPullToRefreshPlugin!

    var pullToRefreshDidTrigger: (() -> Void)?
    
    var tableView: UITableView!
    var customBar: WLYArticleNavigationBar!
    var posterImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func stopRefreshing() {
        self.customBar.stopLoading()
        self.pullToRefreshPlugin.pullToRefreshEnd(result: true)
    }
    
    // MARK:- Private Methods
    
    private func setupView() {
        self.posterImageView = UIImageView()
        self.addSubview(self.posterImageView)
        self.posterImageView.clipsToBounds = true
        self.posterImageView.contentMode = .scaleAspectFill
        self.posterImageView.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(self)
            make.height.equalTo(BarViewHeight)
        }
        
        self.customBar = WLYArticleNavigationBar()
        self.addSubview(self.customBar)
        self.customBar.alpha = 0
        self.customBar.snp.makeConstraints { (make) in
            make.edges.equalTo(self.posterImageView)
        }
    
        self.tableView = UITableView(frame: CGRect.zero, style: UITableViewStyle.plain)
        self.addSubview(tableView)
        self.tableView.register(WLYArticleTableViewCell.self , forCellReuseIdentifier: WLYArticleTableViewCell.identifier)
        self.tableView.frame = CGRect(x: 0, y: BarViewHeight, width: self.wly_width, height: self.wly_height - BarViewHeight);
        self.tableView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self)
            make.top.equalTo(self.posterImageView.snp.bottom)
        }
        
        self.pullToRefreshPlugin = WLYPullToRefreshPlugin(self.tableView)
        self.pullToRefreshPlugin.delegate = self
    }

    // MARK:- WLYPullToRefreshPluginDelegate
    
    func pullToRefreshScrollViewDidPull(scrollView: UIScrollView) {
        let ratio: CGFloat = (self.tableView.contentOffset.y) / -TriggerRefreshHeigh
        self.customBar.showPullProgress(ratio)
    }
    
    func pullToRefreshScrollViewDidTrigger(scrollView: UIScrollView) {
        self.customBar.startLoading()
        
        self.pullToRefreshDidTrigger?()
    }
    
    func pullToRefreshScrollViewDidStopRefresh(scrollView: UIScrollView) {
        self.customBar.stopLoading()
    }
    
    func pullToRefreshScrollViewDidScroll(scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y
        if y <= 0 && y >= -BarViewHeight {
            var rect = self.posterImageView.frame
            rect.size.height = BarViewHeight - y
            self.posterImageView.frame = rect
        }
    }

}
