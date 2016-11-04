//
//  WLYArticleListViewController.swift
//  zhihuSwiftDemo
//
//  Created by Afluy on 16/7/30.
//  Copyright © 2016年 helios. All rights reserved.
//

import UIKit
import SnapKit

class WLYArticleListViewController: WLYTableViewController {

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
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.triggerRefreshHeigh = 50
        
        self.setupView()
        self.bindAction()
        self.loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.scrollImageView.startAutoScroll()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.scrollImageView.stopAutoScroll()
    }
    
    func bindAction() {
        self.customBar.leftButton.addTarget(self, action: #selector(showMenuView), for: .touchUpInside)
    }
    
    func showMenuView() {
        NotificationCenter.default.post(name: Notification.Name(rawValue: WLYSideMenuViewController.WLYNoticationNameShowMenuView), object: nil)
    }
    
    func loadData() {
        ArticleService.requestLatestArticles { (dailyArticle: WLYDailyArticle?, error: Error?) in
            if error == nil {
                self.articles = dailyArticle?.articles
                
                var imageURLs = Array<URL>()
                for article in (dailyArticle?.articles)! {
                    if let imageURL = article.imageURLs?[0] {
                        imageURLs.append(imageURL as URL)
                    }
                }
                
                self.scrollImageView.imageURLs = imageURLs as Array<URL>?
            } else {
                
            }
//            self.scrollViewDidStopRefresh()
            
            let time = DispatchTime.now() + Double((Int64)(3 * NSEC_PER_SEC)) / Double(NSEC_PER_SEC)
            DispatchQueue.main.asyncAfter(deadline: time) {
                self.scrollViewDidStopRefresh()
            }
        }
       
    }
    
    func setupView() {
        self.tableView.dataSource = self
        self.tableView.contentInset = UIEdgeInsetsMake(PosterImageViewHeight, 0, 0, 0)
        self.tableView.register(WLYArticleTableViewCell.self , forCellReuseIdentifier: WLYArticleTableViewCell.identifier)
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
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
        self.view.addSubview(self.customBar)
        self.customBar.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(self.view)
            make.height.equalTo(BarViewHeight)
        }
    }
    
    // MARK: TableView DataSource
    override public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articles?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAtIndexPath indexPath: IndexPath) -> CGFloat {
        return TableCellHeight
    }
    
    override public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WLYArticleTableViewCell.identifier) as? WLYArticleTableViewCell
        
        let article = self.articles?[indexPath.row]
        cell?.titleLabel.text = article?.title
        cell?.logoImageView.kf.setImage(with:article?.imageURLs?[0])
        
        return cell!
    }
    
    private func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath) {
        
        let articleDetailVC = WLYArticleDetailCollectionViewController()//WLYArticleDetailViewController()
        let articleIDs: Array<String>? = self.articles?.map({ (article: WLYArticle) -> String in
            return "\(article.id!)"
        })
        
        articleDetailVC.articleIDs = articleIDs!
        articleDetailVC.currentIndex = indexPath.row
        self.navigationController?.pushViewController(articleDetailVC, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: ScrollView Delegate
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        super.scrollViewDidScroll(scrollView)
    
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
}
