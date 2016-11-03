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

    fileprivate var backgroundView: UIView!
    fileprivate var arrow: UIImageView!
    fileprivate var indicator: UIActivityIndicatorView!

//    private var scrollViewInsets: UIEdgeInsets = UIEdgeInsetsZero

    // MARK: UIView

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect, down:Bool=true, refreshCompletion :((Void) -> Void)?) {
        super.init(frame: frame, down:down, refreshCompletion: refreshCompletion)
        
        self.refreshCompletion = refreshCompletion
        
        self.backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        self.backgroundView.backgroundColor = UIColor.clear
        self.backgroundView.autoresizingMask = UIViewAutoresizing.flexibleWidth
        
        self.arrow = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        self.arrow.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin]
        self.arrow.image = UIImage(named: "ZHAnswerViewBack")
        
        self.indicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        self.indicator.bounds = self.arrow.bounds
        self.indicator.autoresizingMask = self.arrow.autoresizingMask
        self.indicator.hidesWhenStopped = true
        
        self.addSubview(indicator)
        self.addSubview(backgroundView)
        self.addSubview(arrow)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.arrow.center = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2)
        self.arrow.frame = arrow.frame.offsetBy(dx: 0, dy: 0)
        self.indicator.center = self.arrow.center
    }

    //MARK: Override Methods
    
    override func startPullAction(_ scrollView: UIScrollView) {
        super.startPullAction(scrollView)
        
        UIView.animate(withDuration: 0.2, animations: {
            self.arrow.transform = CGAffineTransform.identity
        }) 
    }
  
    override func startPullTriggeredAction(_ scrollView: UIScrollView) {
        super.startPullTriggeredAction(scrollView)
        
        UIView.animate(withDuration: 0.2,
                                   delay: 0,
                                   options:[],
                                   animations: {
                                        // -0.0000001 for the rotation direction control
                                        self.arrow.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI-0.0000001))
                                    },
                                   completion:nil)
    }
    

    override func startRefreshAction(_ scrollView: UIScrollView) {
        super.startRefreshAction(scrollView)
        
        self.indicator.stopAnimating()
        self.arrow.isHidden = false
    }
    
  
    override func stopRefreshAction(_ scrollView: UIScrollView) {
        super.stopRefreshAction(scrollView)
        
        self.arrow.transform = CGAffineTransform.identity
    }
}
