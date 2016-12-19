//
//  WLYArticleListViewController.swift
//  zhihuSwiftDemo
//
//  Created by Afluy on 16/7/30.
//  Copyright © 2016年 helios. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift

class WLYArticleListViewController: WLYViewController {
    private let disposeBag = DisposeBag()

    private var listView: WLYArticleListView!
    
    private var articles: Array<WLYArticle>? {
        didSet {
            self.listView.articles = self.articles
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
        
        self.setupView()
        self.bindAction()
        self.loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.listView.startPosterAutoScroll()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.listView.stopPosterAutoScroll()
    }
    
    private func setupView() {
        self.listView = WLYArticleListView()
        self.view.addSubview(self.listView)
        self.listView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }
    
    private func bindAction() {
        self.listView.tableViewDidSelect = {[weak self] (index) in
            let articleDetailVC = WLYArticleDetailCollectionViewController()//WLYArticleDetailViewController()
            let articleIDs: Array<String>? = self?.articles?.map({ (article: WLYArticle) -> String in
                return "\(article.id!)"
            })
            
            articleDetailVC.articleIDs = articleIDs!
            articleDetailVC.currentIndex = index
            self?.navigationController?.pushViewController(articleDetailVC, animated: true)
        }
        
        self.listView.customBar.leftButton.rx.tap.subscribe(
            onNext:{ [weak self] in
                self?.showMenuView()
            }).addDisposableTo(disposeBag)
        
        self.listView.pullToRefreshDidTrigger = { [weak self] in
            self?.loadData()
        }
    }
    
    private func loadData() {
        ArticleService.requestLatestArticles().subscribe(
            onNext: { [weak self](dailtArticle: WLYDailyArticle) in
                self?.articles = dailtArticle.articles
                var imageURLs = Array<URL>()
                for article in (dailtArticle.articles)! {
                    if let imageURL = article.imageURLs?[0] {
                        imageURLs.append(imageURL as URL)
                    }
                }
                self?.listView.posterImageURLs = imageURLs
                
            }, onError: { [weak self] (error: Error)  in
                print(error)
                self?.stopRefreshing()
                
            }, onCompleted: { [weak self] in
                self?.stopRefreshing()
            }).addDisposableTo(disposeBag)
    }
    
    private func showMenuView() {
        NotificationCenter.default.post(name: WLYSideMenuViewController.WLYNoticationNameShowMenuView)
    }
    
    private func stopRefreshing() {
        DispatchQueue.main.asyncAfter(time: 3, execute: { [weak self] in
            self?.listView.stopRefreshing(result: true)
        })
    }
}
