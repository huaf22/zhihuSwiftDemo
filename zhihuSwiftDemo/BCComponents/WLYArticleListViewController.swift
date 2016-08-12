//
//  WLYArticleListViewController.swift
//  zhihuSwiftDemo
//
//  Created by Afluy on 16/7/30.
//  Copyright © 2016年 helios. All rights reserved.
//

import UIKit

class WLYArticleListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let PosterImageViewHeight: CGFloat = 100
    
    var tableView: UITableView!
    var navigationBar: WLYArticleNavigationBar?
    var scrollImageView: WLYScrollImageView!
    
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
        
        self.navigationBar?.title = "知乎日报"
        loadCustomNavigation()
        loadContentViews()
        
        loadData()
    }
    
    func loadData() {
        ArticleService.requestLatestArticles { (dailyArticle: WLYDailyArticle?, error: NSError?) in
            if error != nil {
               
            } else {
                 self.articles = dailyArticle?.articles
            }
        }
    }
    
    func loadCustomNavigation() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        self.navigationBar = WLYArticleNavigationBar()
       
        self.view.addSubview(self.navigationBar!)
        self.navigationBar?.snp_makeConstraints(closure: { (make) in
            make.left.right.top.equalTo(self.view)
            make.height.equalTo(44)
        })
    }
    
    func loadContentViews() {
        self.tableView = UITableView(frame: CGRectZero, style: UITableViewStyle.Plain)
        self.view.addSubview(tableView)
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
         self.tableView.contentInset = UIEdgeInsetsMake(PosterImageViewHeight, 0, 0, 0)
        self.tableView.registerClass(WLYArticleTableViewCell.self , forCellReuseIdentifier: WLYArticleTableViewCell.identifier)
        self.tableView.snp_makeConstraints(closure: { (make) in
            make.edges.equalTo(self.view)
        })
        
        self.scrollImageView = WLYScrollImageView()
        self.tableView.addSubview(self.scrollImageView)
        self.scrollImageView.snp_makeConstraints { (make) in
            make.left.right.top.equalTo(self.tableView)
            make.height.equalTo(PosterImageViewHeight)
        }
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articles?.count ?? 0
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50.0;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(WLYArticleTableViewCell.identifier) as? WLYArticleTableViewCell
        
        let article = self.articles?[indexPath.row]
        cell?.titleLabel.text = article?.title
        cell?.logoImageView.kf_setImageWithURL(article?.imageURLs?[0])
        
        return cell!;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        NSLog("didSelectRowAtIndexPath: \(indexPath.row)")
    }
}


