//
//  WLYArticleListViewController.swift
//  zhihuSwiftDemo
//
//  Created by Afluy on 16/7/30.
//  Copyright © 2016年 helios. All rights reserved.
//

import UIKit

class WLYArticleListViewController: WLYViewController, UITableViewDelegate, UITableViewDataSource {
    let PosterImageViewHeight: CGFloat = 200
    let BarViewHeight = 58
    
    var tableView: UITableView!
    var topView: UIView!
    var customBar: WLYArticleNavigationBar!
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
        }
    }
    
    func setupView() {
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
            make.left.right.equalTo(self.tableView)
            make.top.equalTo(self.tableView).offset(-PosterImageViewHeight)
            make.height.equalTo(PosterImageViewHeight)
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

        if let article = self.articles?[indexPath.row] {
            let articleDetailVC = WLYArticleDetailViewController()
            articleDetailVC.articleID = article.id!
            self.navigationController?.pushViewController(articleDetailVC, animated: true)
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let alpha: CGFloat = 1 + scrollView.contentOffset.y / PosterImageViewHeight
        if alpha >= 0 || alpha <= 1 {
            self.topView.alpha = alpha
        }
    }
}


