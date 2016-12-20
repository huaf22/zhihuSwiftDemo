//
//  WLYArticleDetailCollectionView.swift
//  zhihuSwiftDemo
//
//  Created by Afluy on 20/12/2016.
//  Copyright © 2016 helios. All rights reserved.
//

import Foundation
import UIKit

class WLYArticleDetailCollectionView: UIView {
    private let ToolViewHeight: CGFloat = 43
    
    var collectionView: UICollectionView!
    var toolBar: WLYArticleDetailToolBarView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        
    }
    
    private func setupView() {
        let collectionViewLayout = UICollectionViewFlowLayout()
        self.collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: collectionViewLayout)
        self.addSubview(self.collectionView)
        self.collectionView.isScrollEnabled = false
        self.collectionView.backgroundColor = UIColor.white
        self.collectionView.register(WLYArticleDetailCell.self, forCellWithReuseIdentifier: WLYArticleDetailCell.identifier)
        self.collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        
        self.toolBar = WLYArticleDetailToolBarView()
        self.addSubview(self.toolBar)
        self.toolBar.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self)
            make.height.equalTo(ToolViewHeight)
        }
    }
}
