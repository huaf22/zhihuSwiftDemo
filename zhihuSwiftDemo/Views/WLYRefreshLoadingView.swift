//
//  WLYRefreshLoadingView.swift
//  zhihuSwiftDemo
//
//  Created by Afluy on 16/8/16.
//  Copyright © 2016年 helios. All rights reserved.
//

import Foundation
import UIKit

class WLYRefreshLoadingView: UIView {
    
    var endAngle: CGFloat = 0
    
    var shouldShowPath = false {
        didSet {
            if !shouldShowPath {
                endAngle = 0
            }
        }
    }
    
    var loadingView: UIActivityIndicatorView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupView() {
        self.loadingView = UIActivityIndicatorView()
        self.addSubview(self.loadingView)
        self.loadingView.snp_makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        
        self.loadingView.hidden = true
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        if shouldShowPath {
            WLYLog.i("drawRect endAngle: \(self.endAngle)")
        
            let path = UIBezierPath(arcCenter: self.wly_center,
                                    radius: self.wly_height / 4,
                                    startAngle: degressToRadians(0),
                                    endAngle: degressToRadians(self.endAngle),
                                    clockwise: true)
            UIColor.whiteColor().setStroke()
            path.lineWidth = 2
            path.stroke()
        }
    }
    
    func showPullProgress(ratio: CGFloat) {
        if ratio >= 0 && ratio <= 100 {
            self.loadingView.hidden = true
            self.shouldShowPath = true
            self.endAngle = ratio * 360
            
            self.setNeedsDisplay()
        }
    }
    
    func startLoading() {
        self.loadingView.hidden = false
        self.shouldShowPath = false
        
        self.loadingView.startAnimating()
        
        self.setNeedsDisplay()
    }
    
    func stopLoading() {
        self.loadingView.stopAnimating()
        self.loadingView.hidden = true
    }
    
    func degressToRadians(angle: CGFloat) -> CGFloat {
        return CGFloat(((angle) / 180.0 * CGFloat(M_PI)))
    }
}
