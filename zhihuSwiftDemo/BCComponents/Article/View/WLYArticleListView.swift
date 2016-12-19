//
//  WLYArticleListView.swift
//  zhihuSwiftDemo
//
//  Created by Afluy on 19/12/2016.
//  Copyright © 2016 helios. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import RxCocoa

class WLYArticleListView: UIView, UITableViewDataSource, UITableViewDelegate, WLYPullToRefreshPluginDelegate {
    private let BarViewHeight: CGFloat = 58
    private let TableCellHeight: CGFloat = 95
    private let PosterImageViewHeight: CGFloat = 200
    private let triggerRefreshHeigh: CGFloat = 50.0
    private let disposeBag = DisposeBag()
    
    private var pullToRefreshPlugin: WLYPullToRefreshPlugin!
    
    private var scrollImageView: WLYScrollImageView!
    
    private var scrollViewTopConstraint: Constraint!
    private var scrollViewHeightConstraint: Constraint!
    
    var tableView: UITableView!
    var customBar: WLYArticleNavigationBar!
    
    var tableViewDidSelect: ((NSInteger) -> Void)?
    var pullToRefreshDidTrigger: (() -> Void)?
    
    var articles: Array<WLYArticle>? {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    var posterImageURLs: Array<URL>? {
        didSet {
            self.scrollImageView.imageURLs = self.posterImageURLs
        }
    }
    
    // MARK:- LifeCrycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupView()
        self.pullToRefreshPlugin = WLYPullToRefreshPlugin(self.tableView)
        self.pullToRefreshPlugin.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK:- Public Methods
    
    func startPosterAutoScroll() {
        self.scrollImageView.startAutoScroll()
    }
    
    func stopPosterAutoScroll() {
        self.scrollImageView.stopAutoScroll()
    }
    
    func stopRefreshing(result success: Bool) {
        self.customBar.stopLoading()
        self.pullToRefreshPlugin.pullToRefreshEnd(result: success)
    }
    
    // MARK:- Private Methods
    
    private func setupView() {
        self.tableView = UITableView(frame: CGRect.zero, style: UITableViewStyle.plain)
        self.addSubview(tableView)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.contentInset = UIEdgeInsetsMake(PosterImageViewHeight, 0, 0, 0)
        self.tableView.register(WLYArticleTableViewCell.self , forCellReuseIdentifier: WLYArticleTableViewCell.identifier)
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        
        self.scrollImageView = WLYScrollImageView()
        self.tableView.addSubview(self.scrollImageView)
        self.scrollImageView.clipsToBounds = true
        self.scrollImageView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.tableView)
            self.scrollViewTopConstraint =  make.top.equalTo(self.tableView).offset(-PosterImageViewHeight).constraint
            self.scrollViewHeightConstraint = make.height.equalTo(PosterImageViewHeight).constraint
            make.width.equalTo(self.tableView)
        }
        
        self.customBar = WLYArticleNavigationBar()
        self.addSubview(self.customBar)
        self.customBar.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(self)
            make.height.equalTo(BarViewHeight)
        }
    }
    
    // MARK:- TableView DataSource & Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articles?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return TableCellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WLYArticleTableViewCell.identifier) as? WLYArticleTableViewCell
        
        let article = self.articles?[indexPath.row]
        cell?.titleLabel.text = article?.title
        cell?.logoImageView.kf.setImage(with:article?.imageURLs?[0])
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableViewDidSelect?(indexPath.row)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK:- WLYPullToRefreshPluginDelegate
    
    func pullToRefreshScrollViewDidPull(scrollView: UIScrollView) {
        let ratio: CGFloat = (self.tableView.contentOffset.y + PosterImageViewHeight) / -self.triggerRefreshHeigh
        self.customBar.showPullProgress(ratio)
        print("ratio: \(ratio)")
    }
    
    func pullToRefreshScrollViewDidTrigger(scrollView: UIScrollView) {
        self.customBar.startLoading()
        
        self.pullToRefreshDidTrigger?()
    }
    
    func pullToRefreshScrollViewDidStopRefresh(scrollView: UIScrollView) {
        self.customBar.stopLoading()
    }
    
    func pullToRefreshScrollViewDidScroll(scrollView: UIScrollView) {
        let alpha: CGFloat = 1 + scrollView.contentOffset.y / PosterImageViewHeight
        if alpha >= 0 || alpha <= 1 {
            self.customBar.alpha = alpha
        }
        
        let y = scrollView.contentOffset.y
        if y <= 0 {
            self.scrollViewTopConstraint.update(offset: y)
            self.scrollViewHeightConstraint.update(offset: -y)
        }
    }
}
