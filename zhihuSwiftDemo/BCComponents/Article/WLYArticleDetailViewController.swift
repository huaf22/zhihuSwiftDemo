//
//  WLYArticleDetailViewController.swift
//  zhihuSwiftDemo
//
//  Created by Afluy on 16/8/13.
//  Copyright © 2016年 helios. All rights reserved.
//

import Foundation
import UIKit

class WLYArticleDetailViewController: WLYViewController, UIScrollViewDelegate, UIGestureRecognizerDelegate {
    let ToolViewHeight: CGFloat = 43
    let ImageViewHeight: CGFloat = 220
    
    var articleID: Int!
    
    var webView: UIWebView!
    var imageView: UIImageView!
    var toolBar: WLYArticleDetailToolBarView!
    
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
        
        self.navigationController?.navigationBarHidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.navigationBarHidden = false
    }
    
    func setupView() {
        let screenWidth = UIScreen.mainScreen().bounds.size.width
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.webView = UIWebView()
        self.view.addSubview(self.webView)
        self.webView.snp_makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
        self.imageView = UIImageView()
        self.webView.scrollView.addSubview(self.imageView)
        self.imageView.clipsToBounds = true
        self.imageView.contentMode = .ScaleAspectFill
        self.imageView.frame = CGRectMake(0, 0, screenWidth, ImageViewHeight);
        self.webView.scrollView.delegate = self

        self.toolBar = WLYArticleDetailToolBarView()
        self.view.addSubview(self.toolBar)
        self.toolBar.snp_makeConstraints { (make) in
            make.left.right.bottom.equalTo(self.view)
            make.height.equalTo(ToolViewHeight)
        }
        
        self.webView.scrollView.contentInset = UIEdgeInsetsMake(0, 0, ToolViewHeight, 0)
        self.webView.scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(ImageViewHeight, 0, ToolViewHeight, 0)
    }
    
    func bindAction() {
        self.toolBar.backButton.addTarget(self, action: #selector(back), forControlEvents: .TouchUpInside)
    }
    
    func loadData() {
        ArticleService.requestArticleDetail("3892357") { (articleDetail: WLYArticleDetail?, error: NSError?) in
            if error == nil {
                if let htmlString = ArticleHTMLParser.parseHTML(articleDetail!) {
                    self.webView.loadHTMLString(htmlString, baseURL: nil)
                    self.imageView.kf_setImageWithURL(articleDetail?.posterURL)
                    return
                }
            }
            
            // handle error
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
    }
    
    func back() {
        self.navigationController?.popViewControllerAnimated(true)
    }
 
}