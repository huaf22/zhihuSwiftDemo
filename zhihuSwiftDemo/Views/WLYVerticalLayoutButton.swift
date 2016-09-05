//
//  WLYVerticalLayoutButton.swift
//  zhihuSwiftDemo
//
//  Created by Afluy on 16/8/16.
//  Copyright © 2016年 helios. All rights reserved.
//

import Foundation
import UIKit

class WLYVerticalLayoutButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if self.imageView != nil && self.titleLabel != nil {
            let imageHW: CGFloat = min((self.imageView?.wly_width)!, (self.imageView?.wly_height)!)
            self.imageView?.frame = CGRectMake(0, 0, imageHW, imageHW)
            self.imageView?.center = CGPointMake(self.wly_width / 2, imageHW / 2)
            
            let titleLabelY = self.wly_height - (self.titleLabel?.wly_height)!
            self.titleLabel?.frame = CGRectMake(0, titleLabelY, self.wly_width, (self.titleLabel?.wly_height)!)
            self.titleLabel?.textAlignment = .Center
        }
    }
}
