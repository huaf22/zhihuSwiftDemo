//
//  WLYScrollImageVIew.swift
//  zhihuSwiftDemo
//
//  Created by Afluy on 16/7/30.
//  Copyright © 2016年 helios. All rights reserved.
//

import UIKit
import  Kingfisher
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func <= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l <= r
  default:
    return !(rhs < lhs)
  }
}


class WLYScrollImageView: UIView, UIScrollViewDelegate {
    let AnimationDuration: TimeInterval = 1
    let TimerDuration: TimeInterval = 3
    let BaseTagIndex = 10000
    
    var pageControl: UIPageControl!
    var scrollView: UIScrollView!
    var scrollTimer: Timer?
    
    var currentIndex: Int = 0 {
        didSet {
            self.pageControl.currentPage = currentIndex
        }
    }
    
    var imageURLs : Array<URL>? {
        didSet {
            self.initScrollViewContent()
            self.startAutoScroll()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupView() {
        self.scrollView = UIScrollView()
        self.scrollView.frame = self.frame
        self.scrollView.delegate = self
        self.scrollView.showsVerticalScrollIndicator = false
        self.scrollView.showsVerticalScrollIndicator = false
        self.scrollView.scrollsToTop = false
        self.scrollView.isPagingEnabled = true
        self.scrollView.bounces = true
        self.addSubview(self.scrollView)
        self.scrollView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        
        self.pageControl = UIPageControl()
        self.addSubview(self.pageControl)
        self.pageControl.snp.makeConstraints { (make) in
            make.bottom.equalTo(self)
            make.centerX.equalTo(self)
            make.height.equalTo(50)
        }
    }
  
    func initScrollViewContent() {
        let count = self.imageURLs?.count > 1 ? 3 : 1;
        self.scrollView.contentSize = CGSize(width: self.wly_width * CGFloat(count), height: self.frame.size.height)
        
        //clear all content view
        for view in self.scrollView.subviews {
            view.removeFromSuperview()
        }
        
        for index in 0..<count {
            let imageView = UIImageView()
            self.scrollView.addSubview(imageView)
            imageView.tag = BaseTagIndex + index
            imageView.contentMode = .scaleAspectFill
            imageView.snp.makeConstraints { (make) in
                make.left.equalTo(self.wly_width * CGFloat(index))
                make.top.bottom.equalTo(self)
                make.width.equalTo(self.wly_width)
            }
        }
        
        self.pageControl.numberOfPages = self.imageURLs != nil ? (self.imageURLs?.count)! : 0
        self.updateScrollViewContent()
    }
    
    func updateScrollViewContent() {
        if self.imageURLs?.count <= 1 {
            let imagView = self.scrollView.viewWithTag(0) as! UIImageView
            imagView.kf.setImage(with:self.imageURLs!.first)
            
            self.scrollView.setContentOffset(CGPoint.zero, animated:false)
            return;
        }
        
        self.currentIndex = self.calcuateCurrentIndex()
        let leftImageIndex  = self.calculateLeftIndex()
        let rightImageIndex = self.calculateRightIndex()
        
        (self.scrollView.viewWithTag(BaseTagIndex + 0) as? UIImageView)!.kf.setImage(with:self.imageURLs![leftImageIndex])
        (self.scrollView.viewWithTag(BaseTagIndex + 1) as? UIImageView)!.kf.setImage(with:self.imageURLs![self.currentIndex])
        (self.scrollView.viewWithTag(BaseTagIndex + 2) as? UIImageView)!.kf.setImage(with:self.imageURLs![rightImageIndex])
        
        self.scrollView.setContentOffset(CGPoint(x: self.scrollView.wly_width, y: 0), animated: false)
    }
    
    func calcuateCurrentIndex() -> Int {
        let offset : CGPoint = self.scrollView.contentOffset
        let totalCount : Int = (self.imageURLs?.count)!
        var index : Int = 0
        
        if offset.x > self.scrollView.wly_width {
            index = (self.currentIndex + 1) % totalCount
        } else if offset.x < self.scrollView.wly_width {
            index = (self.currentIndex + totalCount - 1) % totalCount
        }
        
        if index >= totalCount {
            index = 0
        }
        
//        print("calcuateCurrentIndex: \(index)")
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
        UIView.animate(withDuration: AnimationDuration, animations: {
            self.scrollView.setContentOffset(CGPoint(x: self.scrollView.wly_width * 2.0, y: 0), animated: false)
        }, completion: { (finished) in
            self.updateScrollViewContent()
        }) 
    }
    
    func startAutoScroll() {
        self.stopAutoScroll()

        if self.imageURLs != nil && (self.imageURLs?.count)! > 1  {
            self.scrollTimer = Timer.scheduledTimer(timeInterval: TimerDuration,
                                                                      target: self,
                                                                      selector: #selector(scrollToNextPage),
                                                                      userInfo: nil,
                                                                      repeats: true)
            
            RunLoop.current.add(self.scrollTimer!, forMode: RunLoopMode.defaultRunLoopMode)
        }
    }
    
    func stopAutoScroll() {
        if self.scrollTimer != nil {
            self.scrollTimer?.invalidate()
            self.scrollTimer = nil
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.updateScrollViewContent()
    }
    
}
