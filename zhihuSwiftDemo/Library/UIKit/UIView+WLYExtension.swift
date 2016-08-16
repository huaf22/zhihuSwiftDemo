//
//  UIView+WLYExtension.swift
//  zhihuSwiftDemo
//
//  Created by Afluy on 16/8/8.
//  Copyright © 2016年 helios. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    var wly_height: CGFloat {
        return self.frame.size.height
    }
    
    var wly_width: CGFloat {
        return self.frame.size.width
    }
    
    var wly_center: CGPoint {
        return CGPointMake(self.wly_width / 2, self.wly_height / 2)
    }
}
