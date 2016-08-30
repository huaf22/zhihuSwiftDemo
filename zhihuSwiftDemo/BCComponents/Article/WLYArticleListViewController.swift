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
    let TableCellHeight: CGFloat = 95
    let PosterImageViewHeight: CGFloat = 200
    
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
        
        self.triggerRefreshHeigh = 50
        
        self.setupView()
        self.bindAction()
        self.loadData()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setNeedsStatusBarAppearanceUpdate()
        
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
                
                var imageURLs = Array<NSURL>()
                for article in (dailyArticle?.articles)! {
                    if let imageURL = article.imageURLs?[0] {
                        imageURLs.append(imageURL)
                    }
                }
                
                self.scrollImageView.imageURLs = imageURLs
            } else {
                
            }
//            self.scrollViewDidStopRefresh()
            
            let time = dispatch_time(DISPATCH_TIME_NOW, (Int64)(3 * NSEC_PER_SEC))
            dispatch_after(time, dispatch_get_main_queue()) {
                self.scrollViewDidStopRefresh()
            }
        }
       
    }
    
    func setupView() {
        self.tableView.dataSource = self
        self.tableView.contentInset = UIEdgeInsetsMake(PosterImageViewHeight, 0, 0, 0)
        self.tableView.registerClass(WLYArticleTableViewCell.self , forCellReuseIdentifier: WLYArticleTableViewCell.identifier)
        self.tableView.snp_makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
        self.scrollImageView = WLYScrollImageView()
        self.tableView.addSubview(self.scrollImageView)
        self.scrollImageView.clipsToBounds = true
        self.scrollImageView.snp_makeConstraints { (make) in
            make.left.right.equalTo(self.tableView)
            self.scrollViewTopConstraint =  make.top.equalTo(self.tableView).offset(-PosterImageViewHeight).constraint
            self.scrollViewHeightConstraint = make.height.equalTo(PosterImageViewHeight).constraint
            make.width.equalTo(self.tableView)
        }
        
        self.customBar = WLYArticleNavigationBar()
        self.view.addSubview(self.customBar)
        self.customBar.snp_makeConstraints { (make) in
            make.left.right.top.equalTo(self.view)
            make.height.equalTo(BarViewHeight)
        }
    }
    
    // MARK: TableView DataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articles?.count ?? 0
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return TableCellHeight
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(WLYArticleTableViewCell.identifier) as? WLYArticleTableViewCell
        
        let article = self.articles?[indexPath.row]
        cell?.titleLabel.text = article?.title
        cell?.logoImageView.kf_setImageWithURL(article?.imageURLs?[0])
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let articleDetailVC = WLYArticleDetailCollectionViewController()//WLYArticleDetailViewController()
        let articleIDs: Array<String>? = self.articles?.map({ (article: WLYArticle) -> String in
            return "\(article.id!)"
        })
        
        articleDetailVC.articleIDs = articleIDs!
        articleDetailVC.currentIndex = indexPath.row
        self.navigationController?.pushViewController(articleDetailVC, animated: true)
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    // MARK: ScrollView Delegate
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        super.scrollViewDidScroll(scrollView)
    
        let alpha: CGFloat = 1 + scrollView.contentOffset.y / PosterImageViewHeight
        if alpha >= 0 || alpha <= 1 {
            self.customBar.alpha = alpha
        }
        
        let y = scrollView.contentOffset.y
        if y <= 0 {
            self.scrollViewTopConstraint.updateOffset(y)
            self.scrollViewHeightConstraint.updateOffset(-y)
        }
    }
    
    override func scrollViewDidPull() {
        super.scrollViewDidPull()
        
        let ratio: CGFloat = (self.tableView.contentOffset.y + PosterImageViewHeight) / -self.triggerRefreshHeigh
        self.customBar.showPullProgress(ratio)
        print("ratio: \(ratio)")
    }
    
    override func scrollViewDidRefresh() {
        super.scrollViewDidRefresh()
        
        self.customBar.startLoading()
        self.loadData()
    }
    
    override func scrollViewDidStopRefresh() {
        super.scrollViewDidStopRefresh()
        
        self.customBar.stopLoading()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
}


