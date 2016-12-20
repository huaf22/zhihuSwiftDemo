//
//  WLYArticleChannelViewController.swift
//  zhihuSwiftDemo
//
//  Created by Afluy on 16/8/27.
//  Copyright © 2016年 helios. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift

class WLYArticleChannelViewController: WLYViewController, UITableViewDelegate, UITableViewDataSource {
    private let TableCellHeight: CGFloat = 95
    private let disposeBag = DisposeBag()
    
    private var customView: WLYArticleChannelView!
    
    var theme: WLYArticleTheme? {
        didSet {
            if self.isViewLoaded {
                self.loadData()
            }
        }
    }
    
    private var themeArticles: WLYThemeArticles? {
        didSet {
            self.customView.customBar.title = themeArticles?.name
            self.customView.posterImageView.kf.setImage(with:themeArticles?.ImageURL)
            
            self.customView.tableView.reloadData()
        }
    }
    
    // MARK:- LifeCycle
    
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
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    // MARK:- Private Methods
    
    private func setupView() {
        self.customView = WLYArticleChannelView()
        self.view.addSubview(self.customView)
        self.customView.tableView.delegate = self
        self.customView.tableView.dataSource = self
        self.customView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }
    
    private func bindAction() {
        self.customView.pullToRefreshDidTrigger = { [weak self] in
            self?.loadData()
        }
    }
    
    private func loadData() {
        ArticleService.requestThemeArticlesWithID((theme?.id)!).subscribe(
            onNext:{ [weak self] (themeArticles) in
                self?.themeArticles = themeArticles
                
            }, onError:{ [weak self] (error) in
                print(error)
                self?.customView.stopRefreshing()
                
            }, onCompleted: { [weak self] in
                self?.customView.stopRefreshing()
                
            }).addDisposableTo(disposeBag)
    }
    
    // MARK:- UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.themeArticles?.articles?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return TableCellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WLYArticleTableViewCell.identifier) as! WLYArticleTableViewCell
        
        let article = self.themeArticles?.articles?[indexPath.row]
        cell.titleLabel.text = article?.title
        cell.logoImageView.kf.setImage(with:article?.imageURLs?[0])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let articleDetailVC = WLYArticleDetailCollectionViewController()
        let articleIDs: Array<String>? = self.themeArticles?.articles?.map { (article: WLYArticle) -> String in
            return "\(article.id!)"
        }
        
        articleDetailVC.articleIDs = articleIDs!
        articleDetailVC.currentIndex = indexPath.row
        self.navigationController?.pushViewController(articleDetailVC, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
