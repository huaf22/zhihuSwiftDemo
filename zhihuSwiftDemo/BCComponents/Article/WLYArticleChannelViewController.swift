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
    
    let BarViewHeight: CGFloat = 58
    let TableCellHeight: CGFloat = 95
    
    var customBar: WLYArticleNavigationBar!
    var posterImageView: UIImageView!
    
    var articles: Array<WLYArticle>?
    
    var theme: WLYArticleTheme? {
        didSet {
            if self.isViewLoaded() {
                self.loadData()
            }
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
        self.loadData()
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
        self.posterImageView = UIImageView()
        self.view.addSubview(self.posterImageView)
        self.posterImageView.clipsToBounds = true
        self.posterImageView.contentMode = .ScaleAspectFill
        self.posterImageView.frame = CGRectMake(0, 0, self.view.wly_width, BarViewHeight);
        
        self.customBar = WLYArticleNavigationBar()
        self.view.addSubview(self.customBar)
        self.customBar.alpha = 0
        self.customBar.frame = CGRectMake(0, 0, self.view.wly_width, BarViewHeight);
        
        self.tableView.dataSource = self
        self.tableView.registerClass(WLYArticleTableViewCell.self , forCellReuseIdentifier: WLYArticleTableViewCell.identifier)
        self.tableView.frame = CGRectMake(0, BarViewHeight, self.view.wly_width, self.view.wly_height - BarViewHeight);
    }
    
    func loadData() {
        ArticleService.requestThemeArticlesWithID((theme?.id)!) { (themeArticles: WLYThemeArticles?, error: NSError?) in
            if error == nil {
                self.articles = themeArticles?.articles
                self.customBar.title = themeArticles?.name
                self.posterImageView.kf_setImageWithURL(themeArticles?.ImageURL)
                self.tableView.reloadData()
            } else {
                
                // handle error result
            }
            self.scrollViewDidStopRefresh()
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
        
        let articleDetailVC = WLYArticleDetailCollectionViewController()
        let articleIDs: Array<String>? = self.articles?.map({ (article: WLYArticle) -> String in
            return "\(article.id!)"
        })
        
        articleDetailVC.articleIDs = articleIDs!
        articleDetailVC.currentIndex = indexPath.row
        self.navigationController?.pushViewController(articleDetailVC, animated: true)
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        super.scrollViewDidScroll(scrollView)
        
        let y = scrollView.contentOffset.y
        if y <= 0 && y >= -BarViewHeight {
            var rect = self.posterImageView.frame
            rect.size.height = BarViewHeight - y
            self.posterImageView.frame = rect
        }
    }
    
    override func scrollViewDidPull() {
        super.scrollViewDidPull()
        
        let ratio: CGFloat = (self.tableView.contentOffset.y) / -self.triggerRefreshHeigh
        self.customBar.showPullProgress(ratio)
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
}
