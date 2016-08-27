//
//  WLYArticleChannelViewController.swift
//  zhihuSwiftDemo
//
//  Created by Afluy on 16/8/27.
//  Copyright © 2016年 helios. All rights reserved.
//

import UIKit
import SnapKit

class WLYArticleChannelViewController: WLYTableViewController, UITableViewDataSource {
    
    let TableCellHeight: CGFloat = 95
    
    var customBar: WLYArticleNavigationBar!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    var channel: WLYArticleTheme? {
        didSet {
            self.loadData()
        }
    }
    
    var articles: Array<WLYArticle>?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupView()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func setupView() {
        self.tableView.dataSource = self
        self.tableView.registerClass(WLYArticleTableViewCell.self , forCellReuseIdentifier: WLYArticleTableViewCell.identifier)
        
        self.customBar = WLYArticleNavigationBar()
        self.view.addSubview(self.customBar)
        self.customBar.snp_makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
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
            } else {
                // handle error result
            }
            self.stopRefresh()
        }
    }
    
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
    
    override func didPulling() {
        super.didPulling()
        
        let ratio: CGFloat = (self.tableView.contentOffset.y) / -self.triggerRefreshHeigh
        self.customBar.showPullProgress(ratio)
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
