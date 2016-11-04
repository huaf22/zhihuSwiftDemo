//
//  WLYArticleDetailCell.swift
//  zhihuSwiftDemo
//
//  Created by Afluy on 16/8/17.
//  Copyright © 2016年 helios. All rights reserved.
//

import Foundation
import UIKit

class WLYArticleDetailCell: WLYCollectionViewCell, UIScrollViewDelegate {
    
    let ToolViewHeight: CGFloat = 43
    let ImageViewHeight: CGFloat = 220
    let RefreshHeight: CGFloat = 50
    
    var webView: UIWebView!
    var imageView: UIImageView!
    
    var triggerRefreshHeigh: CGFloat = 50
    
    var indexPath: IndexPath = IndexPath(index:0)
    
    var didScrollToNext: ((_ cell: WLYArticleDetailCell, _ scrollToNext: Bool) -> Void)?
    
    var articleID: String! {
        didSet {
            self.loadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupView() {
        self.webView = UIWebView()
        self.addSubview(self.webView)
        self.webView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        
        self.imageView = UIImageView()
        self.webView.scrollView.addSubview(self.imageView)
        self.imageView.clipsToBounds = true
        self.imageView.contentMode = .scaleAspectFill
        self.imageView.frame = CGRect(x: 0, y: 0, width: self.wly_width, height: ImageViewHeight);
        
        self.webView.scrollView.delegate = self
        self.webView.scrollView.bounces = true
        self.webView.scrollView.contentInset = UIEdgeInsetsMake(0, 0, ToolViewHeight, 0)
        self.webView.scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(ImageViewHeight, 0, ToolViewHeight, 0)
        
        // pull to refresh
        let refreshViewFrame = CGRect(x: 0, y: 0, width: self.webView.scrollView.wly_width, height: RefreshHeight)
        let pullToRefreshView = WLYArticleDetailRefreshView(frame: refreshViewFrame, refreshCompletion: {[weak self] in
            self?.didScrollToNext!(self!, false)
            self?.webView.scrollView.stopPullRefresh()
        });
        self.webView.scrollView.addPullRefreshView(pullToRefreshView)
        
        let pushToRefreshView = WLYArticleDetailRefreshView(frame: refreshViewFrame, down: false, refreshCompletion: {[weak self] in
            self?.didScrollToNext!(self!, true)
            self?.webView.scrollView.stopPushRefresh()

        });
        self.webView.scrollView.addPushRefreshView(pushToRefreshView)
    }
    
    func loadData() {
        if self.articleID != nil && !articleID.isEmpty {
            ArticleService.requestArticleDetail(self.articleID) { (articleDetail, error) in
                if error == nil {
                    if let htmlString = ArticleHTMLParser.parseHTML(articleDetail!) {
                        self.webView.loadHTMLString(htmlString, baseURL: nil)
                        self.imageView.kf.setImage(with: articleDetail?.posterURL)
                        return
                    }
                } else {
                     // handle error
                }
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y
        if y <= 0 {
            var rect = self.imageView.frame
            rect.origin.y = y
            rect.size.height = ImageViewHeight - y
            self.imageView.frame = rect
        }
    }
}

