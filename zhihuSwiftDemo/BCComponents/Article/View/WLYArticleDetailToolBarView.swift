//
//  WLYArticleDetailToolBarView.swift
//  zhihuSwiftDemo
//
//  Created by Afluy on 16/8/15.
//  Copyright © 2016年 helios. All rights reserved.
//

import Foundation
import UIKit

class WLYArticleDetailToolBarView: UIView {
    let ButtonWidth: CGFloat = 45
    let ButtonHeight: CGFloat = 43
    
    var backButton: UIButton!
    var nextButton: UIButton!
    var likeButton: UIButton!
    var shareButton: UIButton!
    var commentButton: UIButton!
    
    var buttonArray: [UIButton]!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupView() {
        self.backgroundColor = UIColor.whiteColor()
        
        self.backButton = UIButton()
        self.backButton.setTitle("back", forState: .Normal)
        
        self.nextButton = UIButton()
        self.nextButton.setTitle("next", forState: .Normal)
        
        self.likeButton = UIButton()
        self.likeButton.setTitle("like", forState: .Normal)
        
        self.shareButton = UIButton()
        self.shareButton.setTitle("share", forState: .Normal)
        
        self.commentButton = UIButton()
        self.commentButton.setTitle("=", forState: .Normal)
        
        self.buttonArray = [self.backButton, self.nextButton, self.likeButton, self.shareButton, self.commentButton]
        
        let width = UIScreen.mainScreen().bounds.width / CGFloat(self.buttonArray.count + 1)
        let height = ButtonHeight / 2
        for index in 0..<self.buttonArray.count {
            let button = self.buttonArray[index]
            self.addSubview(button)
            button.setTitleColor(UIColor.blackColor(), forState: .Normal)
            button.frame = CGRectMake(0, 0, ButtonWidth, ButtonHeight)
            button.center = CGPointMake(width * CGFloat(index + 1), height)
        }
    }
    
}