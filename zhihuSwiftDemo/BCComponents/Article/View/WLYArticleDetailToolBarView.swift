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

        self.backButton = UIButton(type: .Custom)
        self.backButton.setImage(UIImage(named: "News_Navigation_Arrow"), forState: .Normal)
        self.backButton.setImage(UIImage(named: "News_Navigation_Arrow_Highlight"), forState: .Highlighted)
        
        self.nextButton = UIButton(type: .Custom)
        self.nextButton.setImage(UIImage(named: "News_Navigation_Next"), forState: .Normal)
        self.nextButton.setImage(UIImage(named: "News_Navigation_Next_Highlight"), forState: .Highlighted)
        
        self.likeButton = UIButton(type: .Custom)
        self.likeButton.setImage(UIImage(named: "News_Navigation_Vote"), forState: .Normal)
        self.likeButton.setImage(UIImage(named: "News_Navigation_Voted"), forState: .Highlighted)
        
        self.shareButton = UIButton(type: .Custom)
        self.shareButton.setImage(UIImage(named: "News_Navigation_Share"), forState: .Normal)
        self.shareButton.setImage(UIImage(named: "News_Navigation_Share_Highlight"), forState: .Highlighted)
        
        self.commentButton = UIButton(type: .Custom)
        self.commentButton.setImage(UIImage(named: "News_Navigation_Comment"), forState: .Normal)
        self.commentButton.setImage(UIImage(named: "News_Navigation_Comment_Highlight"), forState: .Highlighted)
        
        self.buttonArray = [self.backButton, self.nextButton, self.likeButton, self.shareButton, self.commentButton]
        
        for index in 0..<self.buttonArray.count {
            let button = self.buttonArray[index]
            self.addSubview(button)
            button.imageView?.contentMode = .ScaleAspectFit
            
            let offsetX: CGFloat = UIScreen.mainScreen().bounds.width / CGFloat(self.buttonArray.count + 1) * (CGFloat(index) + 1) - ButtonWidth / 2
            button.snp_makeConstraints(closure: { (make) in
                make.top.bottom.equalTo(self)
                make.width.equalTo(50)
                make.left.equalTo(self).offset(offsetX)
            })
        }
    }
    
}