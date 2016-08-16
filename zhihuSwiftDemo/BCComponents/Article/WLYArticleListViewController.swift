//
//  WLYArticleListViewController.swift
//  zhihuSwiftDemo
//
//  Created by Afluy on 16/7/30.
//  Copyright © 2016年 helios. All rights reserved.
//

import UIKit
import SnapKit

class WLYArticleListViewController: WLYTableViewController, UITableViewDataSource {

    let BarViewHeight: CGFloat = 58
    let TableCellHeight: CGFloat = 50
    let PosterImageViewHeight: CGFloat = 200

    var topView: UIView!
    var customBar: WLYArticleNavigationBar!
    var scrollImageView: WLYScrollImageView!
    
    var scrollViewTopConstraint: Constraint!
    var scrollViewHeightConstraint: Constraint!
    
    var articles: Array<WLYArticle>? {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.triggerRefreshHeigh = 75
        
        self.setupView()
        self.bindAction()
        self.loadData()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.scrollImageView.startAutoScroll()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.scrollImageView.stopAutoScroll()
    }
    
    func bindAction() {
        self.customBar.leftButton.addTarget(self, action: #selector(showMenuView), forControlEvents: .TouchUpInside)
    }
    
    func showMenuView() {
        NSNotificationCenter.defaultCenter().postNotificationName(WLYSideMenuViewController.WLYNoticationNameShowMenuView, object: nil)
    }
    
    func loadData() {
        ArticleService.requestLatestArticles { (dailyArticle: WLYDailyArticle?, error: NSError?) in
            if error == nil {
                self.articles = dailyArticle?.articles
                
                var imageURLs =  Array<NSURL>()
                for article in (dailyArticle?.articles)! {
                    if let imageURL = article.imageURLs?[0] {
                        imageURLs.append(imageURL)
                    }
                }
                
                self.scrollImageView.imageURLs = imageURLs
            } else {
                
            }
            self.stopRefresh()
        }
    }
    
    func setupView() {



        self.tableView.dataSource = self;
        self.tableView.contentInset = UIEdgeInsetsMake(PosterImageViewHeight, 0, 0, 0)
        self.tableView.registerClass(WLYArticleTableViewCell.self , forCellReuseIdentifier: WLYArticleTableViewCell.identifier)
    
        
        self.scrollImageView = WLYScrollImageView()
        self.tableView.addSubview(self.scrollImageView)
        self.scrollImageView.clipsToBounds = true
        self.scrollImageView.snp_makeConstraints { (make) in
            make.left.right.equalTo(self.tableView)
            self.scrollViewTopConstraint =  make.top.equalTo(self.tableView).offset(-PosterImageViewHeight).constraint
            self.scrollViewHeightConstraint = make.height.equalTo(PosterImageViewHeight).constraint
            make.width.equalTo(self.tableView)
        }
        
        self.topView = UIView()
        self.view.addSubview(self.topView)
        self.topView.backgroundColor = UIColor(rgba: "#028fd6")
        self.topView.snp_makeConstraints { (make) in
            make.left.right.top.equalTo(self.view)
            make.height.equalTo(BarViewHeight)
        }
        
        self.customBar = WLYArticleNavigationBar()
        self.view.addSubview(self.customBar)
        self.customBar.snp_makeConstraints { (make) in
            make.edges.equalTo(self.topView)
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articles?.count ?? 0
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return TableCellHeight;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(WLYArticleTableViewCell.identifier) as? WLYArticleTableViewCell
        
        let article = self.articles?[indexPath.row]
        cell?.titleLabel.text = article?.title
        cell?.logoImageView.kf_setImageWithURL(article?.imageURLs?[0])
        
        return cell!;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let article = self.articles?[indexPath.row] {
            let articleDetailVC = WLYArticleDetailViewController()
            articleDetailVC.articleID = article.id!
            self.navigationController?.pushViewController(articleDetailVC, animated: true)
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        super.scrollViewDidScroll(scrollView)
        
        let alpha: CGFloat = 1 + scrollView.contentOffset.y / PosterImageViewHeight
        if alpha >= 0 || alpha <= 1 {
            self.topView.alpha = alpha
        }
        
        let y = scrollView.contentOffset.y
        if y <= 0 {
            self.scrollViewTopConstraint.updateOffset(y)
            self.scrollViewHeightConstraint.updateOffset(-y)
        }
    }
    
    override func didPulling() {
        super.didPulling()
        
        let ratio: CGFloat = (self.tableView.contentOffset.y + PosterImageViewHeight) / -self.triggerRefreshHeigh
        self.customBar.showPullProgress(ratio)
        print("ratio: \(ratio)")

    }
    
    override func didRefreshing() {
        super.didRefreshing()
        
        self.customBar.startLoading()
        self.loadData()
    }

    override func stopRefresh() {
        super.stopRefresh()
        
        self.customBar.stopLoading()
    }
}


