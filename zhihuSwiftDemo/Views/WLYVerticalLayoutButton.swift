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
            self.imageView?.frame = CGRect(x: 0, y: 0, width: imageHW, height: imageHW)
            self.imageView?.center = CGPoint(x: self.wly_width / 2, y: imageHW / 2)
            
            let titleLabelY = self.wly_height - (self.titleLabel?.wly_height)!
            self.titleLabel?.frame = CGRect(x: 0, y: titleLabelY, width: self.wly_width, height: (self.titleLabel?.wly_height)!)
            self.titleLabel?.textAlignment = .center
        }
    }
}
