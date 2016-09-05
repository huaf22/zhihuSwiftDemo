//
//  WLYArticleDetailRefreshView.swift
//  zhihuSwiftDemo
//
//  Created by Afluy on 16/8/30.
//  Copyright © 2016年 helios. All rights reserved.
//

import Foundation
import UIKit

class WLYArticleDetailRefreshView: WLYPullToRefreshView {

    private var backgroundView: UIView!
    private var arrow: UIImageView!
    private var indicator: UIActivityIndicatorView!

//    private var scrollViewInsets: UIEdgeInsets = UIEdgeInsetsZero

    // MARK: UIView

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect, down:Bool=true, refreshCompletion :(Void -> Void)?) {
        super.init(frame: frame, down:down, refreshCompletion: refreshCompletion)
        
        self.refreshCompletion = refreshCompletion
        
        self.backgroundView = UIView(frame: CGRectMake(0, 0, frame.size.width, frame.size.height))
        self.backgroundView.backgroundColor = UIColor.clearColor()
        self.backgroundView.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        
        self.arrow = UIImageView(frame: CGRectMake(0, 0, 30, 30))
        self.arrow.autoresizingMask = [.FlexibleLeftMargin, .FlexibleRightMargin]
        self.arrow.image = UIImage(named: "ZHAnswerViewBack")
        
        self.indicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
        self.indicator.bounds = self.arrow.bounds
        self.indicator.autoresizingMask = self.arrow.autoresizingMask
        self.indicator.hidesWhenStopped = true
        
        self.addSubview(indicator)
        self.addSubview(backgroundView)
        self.addSubview(arrow)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.arrow.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2)
        self.arrow.frame = CGRectOffset(arrow.frame, 0, 0)
        self.indicator.center = self.arrow.center
    }

    //MARK: Override Methods
    
    override func startPullAction(scrollView: UIScrollView) {
        super.startPullAction(scrollView)
        
        UIView.animateWithDuration(0.2) {
            self.arrow.transform = CGAffineTransformIdentity
        }
    }
  
    override func startPullTriggeredAction(scrollView: UIScrollView) {
        super.startPullTriggeredAction(scrollView)
        
        UIView.animateWithDuration(0.2,
                                   delay: 0,
                                   options:[],
                                   animations: {
                                        // -0.0000001 for the rotation direction control
                                        self.arrow.transform = CGAffineTransformMakeRotation(CGFloat(M_PI-0.0000001))
                                    },
                                   completion:nil)
    }
    

    override func startRefreshAction(scrollView: UIScrollView) {
        super.startRefreshAction(scrollView)
        
        self.indicator.stopAnimating()
        self.arrow.hidden = false
    }
    
  
    override func stopRefreshAction(scrollView: UIScrollView) {
        super.stopRefreshAction(scrollView)
        
        self.arrow.transform = CGAffineTransformIdentity
    }
}