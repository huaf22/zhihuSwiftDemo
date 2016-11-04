//
//  WLYHorizontalLayoutButton.swift
//  zhihuSwiftDemo
//
//  Created by Afluy on 16/8/16.
//  Copyright © 2016年 helios. All rights reserved.
//

import Foundation
import UIKit

class WLYHorizontalLayoutButton: UIButton {
    
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
            self.imageView?.center.y = self.wly_height / 2
            
            let titleLabelX = self.wly_width - (self.titleLabel?.wly_width)!
            self.titleLabel?.frame = CGRect(x: titleLabelX, y: 0, width: (self.titleLabel?.wly_width)!, height: (self.titleLabel?.wly_height)!)
            self.titleLabel?.center.y = self.wly_height / 2
            self.titleLabel?.textAlignment = .right
        }
    }
}
