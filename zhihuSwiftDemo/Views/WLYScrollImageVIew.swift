//
//  WLYScrollImageVIew.swift
//  zhihuSwiftDemo
//
//  Created by Afluy on 16/7/30.
//  Copyright © 2016年 helios. All rights reserved.
//

import UIKit
import Kingfisher

class WLYScrollImageVIew: UIView, UIScrollViewDelegate {
    let AnimationDuration : NSTimeInterval = 0.35
    
    var pageControl : UIPageControl!
    var scrollView : UIScrollView!
    var scrollTimer : NSTimer?
    
    var currentIndex : Int = 0 {
        didSet {
            self.pageControl.currentPage = currentIndex
        }
    }
    
    var imageViewArray : Array<UIView> = Array();
    
    var imageURLs : Array<NSURL>? {
        didSet {
            self.initScrollViewContent()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.scrollView = UIScrollView()
        self.scrollView.frame = self.frame
        self.scrollView.delegate = self
        self.scrollView.showsVerticalScrollIndicator = false
        self.scrollView.showsVerticalScrollIndicator = false
        self.scrollView.scrollsToTop = false
        self.scrollView.pagingEnabled = true
        self.scrollView.bounces = true
        self.addSubview(self.scrollView)
        self.scrollView.snp_makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        
        self.pageControl = UIPageControl()
        self.addSubview(self.pageControl)
        self.pageControl.snp_makeConstraints { (make) in
            make.bottom.equalTo(self)
            make.centerX.equalTo(self)
            make.height.equalTo(50)
        }
    }
  
    func initScrollViewContent() {
        let count = self.imageURLs?.count > 1 ? 3 : 1;
        self.scrollView.contentSize = CGSizeMake(self.wly_width() * CGFloat(count), self.frame.size.height)
        
        //clear all content view
        for view in self.scrollView.subviews {
            view.removeFromSuperview()
        }
        
        self.imageViewArray.removeAll()
        
        for index in 0...count {
            let imageView : UIImageView = UIImageView()
            imageView.frame = CGRectMake(self.wly_width() * CGFloat(index), 0, self.wly_width(), self.wly_height())
            imageView.tag = index
            
            self.imageViewArray.append(imageView) //?
            self.scrollView.addSubview(imageView)
        }
        
        self.pageControl.numberOfPages = (self.imageURLs?.count)!
        self.updateScrollViewContent()
    }
    
    func updateScrollViewContent() {
        if self.imageURLs?.count <= 1 {
            let imagView = self.scrollView.viewWithTag(0) as! UIImageView
            imagView.kf_setImageWithURL(self.imageURLs!.first)
            
            self.scrollView.setContentOffset(CGPointZero, animated:false)
            return;
        }
        
        self.currentIndex = self.calcuateCurrentIndex()
        let leftImageIndex  = self.calculateLeftIndex()
        let rightImageIndex = self.calculateRightIndex()
        
        (self.scrollView.viewWithTag(0) as! UIImageView).kf_setImageWithURL(self.imageURLs![leftImageIndex])
        (self.scrollView.viewWithTag(1) as! UIImageView).kf_setImageWithURL(self.imageURLs![self.currentIndex])
        (self.scrollView.viewWithTag(0) as! UIImageView).kf_setImageWithURL(self.imageURLs![rightImageIndex])
        
        self.scrollView.setContentOffset(CGPointMake((self.scrollView?.wly_width())!, 0), animated: false)
    }
    
    func calcuateCurrentIndex() -> Int {
        let offset : CGPoint = self.scrollView.contentOffset
        let totalCount : Int = (self.imageURLs?.count)!
        var index : Int = 0
        
        if offset.x > self.scrollView.wly_width() {
            index = (self.currentIndex + 1) % totalCount
        } else if offset.x < self.scrollView.wly_width() {
            index = (self.currentIndex + totalCount - 1) % totalCount
        }
        
        if index >= totalCount {
            index = 0
        }
        
        NSLog("calcuateCurrentIndex--index: %ld", index)
        return index
    }
    
    func calculateLeftIndex() -> Int {
        let totalCount : Int = (self.imageURLs?.count)!
        return (self.currentIndex + totalCount - 1) % totalCount
    }
    
    func calculateRightIndex() -> Int {
        let totalCount : Int = (self.imageURLs?.count)!
        return (self.currentIndex + 1) % totalCount
    }
    
    func scrollToNextPage() {
        UIView.animateWithDuration(1000, animations: {
            self.scrollView.setContentOffset(CGPointMake(self.scrollView.wly_width() * 2.0, 0), animated: false)
        }) { (finished) in
            self.updateScrollViewContent()
        }
    }
    
    func startAutoScrollTimer() {
        if (self.imageURLs?.count)! > 1  {
            self.scrollTimer = NSTimer.scheduledTimerWithTimeInterval(AnimationDuration,
                                                                      target: self,
                                                                      selector: #selector(scrollToNextPage),
                                                                      userInfo: nil,
                                                                      repeats: true)
            
            NSRunLoop.currentRunLoop().addTimer(self.scrollTimer!, forMode: NSDefaultRunLoopMode)
            NSRunLoop.currentRunLoop().runMode(UITrackingRunLoopMode, beforeDate: NSDate.distantFuture())
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
    }
    
}