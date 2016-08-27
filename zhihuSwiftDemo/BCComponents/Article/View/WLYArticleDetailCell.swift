//
//  WLYArticleDetailCell.swift
//  zhihuSwiftDemo
//
//  Created by Afluy on 16/8/17.
//  Copyright © 2016年 helios. All rights reserved.
//

import Foundation
import UIKit

class WLYArticleDetailCell: UICollectionViewCell, UIScrollViewDelegate {
    enum WLYTableViewLoadingStatus {
        case Normal
        case Pulling
        case Refreshing
    }
    
    let ToolViewHeight: CGFloat = 43
    let ImageViewHeight: CGFloat = 220
    
    var webView: UIWebView!
    var imageView: UIImageView!
    
    var triggerRefreshHeigh: CGFloat = 50
    private var loadingStatus: WLYTableViewLoadingStatus = .Normal
    
    var indexPath: NSIndexPath = NSIndexPath(index:0)
    
    var didScrollToNext: ((cell: WLYArticleDetailCell, scrollToNext: Bool) -> Void)?
    
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
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.webView = UIWebView()
        self.addSubview(self.webView)
        self.webView.snp_makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        
        self.imageView = UIImageView()
        self.webView.scrollView.addSubview(self.imageView)
        self.imageView.clipsToBounds = true
        self.imageView.contentMode = .ScaleAspectFill
        self.imageView.frame = CGRectMake(0, 0, self.wly_width, ImageViewHeight);
        
        self.webView.scrollView.delegate = self
        self.webView.scrollView.contentInset = UIEdgeInsetsMake(0, 0, ToolViewHeight, 0)
        self.webView.scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(ImageViewHeight, 0, ToolViewHeight, 0)
    }
    
    func loadData() {
        if self.articleID != nil && !articleID.isEmpty {
            ArticleService.requestArticleDetail(self.articleID) { (articleDetail: WLYArticleDetail?, error: NSError?) in
                if error == nil {
                    if let htmlString = ArticleHTMLParser.parseHTML(articleDetail!) {
                        self.webView.loadHTMLString(htmlString, baseURL: nil)
                        self.imageView.kf_setImageWithURL(articleDetail?.posterURL)
                        return
                    }
                } else {
                     // handle error
                }
            }
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y
        if y <= 0 {
            var rect = self.imageView.frame
            rect.origin.y = y
            rect.size.height = ImageViewHeight - y
            self.imageView.frame = rect
        }
        
        if y < -scrollView.contentInset.top ||  y > (scrollView.contentSize.height - scrollView.wly_height) {
            if scrollView.dragging {
                if self.loadingStatus == .Normal {
                    self.loadingStatus = .Pulling
                } else if self.loadingStatus == .Pulling {
                    if  y <= (-scrollView.contentInset.top - triggerRefreshHeigh) ||
                        y >= (scrollView.contentSize.height - scrollView.wly_height + triggerRefreshHeigh + scrollView.contentInset.bottom) {
                        self.loadingStatus = .Refreshing
                    }
                }
            }
        }
    }
    
    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if self.loadingStatus == .Refreshing {
            self.webView.scrollView.bounces = false
            
            if self.didScrollToNext != nil {
                let y = scrollView.contentOffset.y
                var scrollToNext = true
                
                if y <= scrollView.contentInset.top {
                    scrollToNext = false
                }
                
                self.didScrollToNext!(cell: self, scrollToNext: scrollToNext)
            }
            
            self.webView.scrollView.bounces = true
            
            self.loadingStatus = .Normal
        }
    }
}

