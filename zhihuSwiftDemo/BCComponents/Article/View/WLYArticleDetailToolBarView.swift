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
        self.backgroundColor = UIColor.white

        self.backButton = UIButton(type: .custom)
        self.backButton.setImage(UIImage(named: "News_Navigation_Arrow"), for: UIControlState())
        self.backButton.setImage(UIImage(named: "News_Navigation_Arrow_Highlight"), for: .highlighted)
        
        self.nextButton = UIButton(type: .custom)
        self.nextButton.setImage(UIImage(named: "News_Navigation_Next"), for: UIControlState())
        self.nextButton.setImage(UIImage(named: "News_Navigation_Next_Highlight"), for: .highlighted)
        
        self.likeButton = UIButton(type: .custom)
        self.likeButton.setImage(UIImage(named: "News_Navigation_Vote"), for: UIControlState())
        self.likeButton.setImage(UIImage(named: "News_Navigation_Voted"), for: .highlighted)
        
        self.shareButton = UIButton(type: .custom)
        self.shareButton.setImage(UIImage(named: "News_Navigation_Share"), for: UIControlState())
        self.shareButton.setImage(UIImage(named: "News_Navigation_Share_Highlight"), for: .highlighted)
        
        self.commentButton = UIButton(type: .custom)
        self.commentButton.setImage(UIImage(named: "News_Navigation_Comment"), for: UIControlState())
        self.commentButton.setImage(UIImage(named: "News_Navigation_Comment_Highlight"), for: .highlighted)
        
        self.buttonArray = [self.backButton, self.nextButton, self.likeButton, self.shareButton, self.commentButton]
        
        for index in 0..<self.buttonArray.count {
            let button = self.buttonArray[index]
            self.addSubview(button)
            button.imageView?.contentMode = .scaleAspectFit
            
            let offsetX: CGFloat = UIScreen.main.bounds.width / CGFloat(self.buttonArray.count + 1) * (CGFloat(index) + 1) - ButtonWidth / 2
            button.snp.makeConstraints({ (make) in
                make.top.bottom.equalTo(self)
                make.width.equalTo(50)
                make.left.equalTo(self).offset(offsetX)
            })
        }
    }
    
}
