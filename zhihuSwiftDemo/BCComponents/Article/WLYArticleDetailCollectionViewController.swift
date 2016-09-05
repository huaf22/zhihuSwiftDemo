//
//  WLYArticleDetailCollectionViewController.swift
//  zhihuSwiftDemo
//
//  Created by Afluy on 16/8/17.
//  Copyright © 2016年 helios. All rights reserved.
//

import Foundation
import UIKit

class WLYArticleDetailCollectionViewController: WLYViewController, UICollectionViewDelegate, UICollectionViewDataSource,
                                                UICollectionViewDelegateFlowLayout, UIGestureRecognizerDelegate {
    let ToolViewHeight: CGFloat = 43
    
    var collectionView: UICollectionView!
    var toolBar: WLYArticleDetailToolBarView!
    
    var currentIndex: Int = 0
    var articleIDs = Array<String>()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        self.setupView()
        self.bindAction()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBarHidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.navigationBarHidden = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.scrollCollectionViewToIndex(self.currentIndex, animated: false)
    }
    
    func setupView() {
        self.automaticallyAdjustsScrollViewInsets = false
        
        let collectionViewLayout = UICollectionViewFlowLayout()
        self.collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: collectionViewLayout)
        self.view.addSubview(self.collectionView)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.scrollEnabled = false
        self.collectionView.backgroundColor = UIColor.whiteColor()
        self.collectionView.registerClass(WLYArticleDetailCell.self, forCellWithReuseIdentifier: WLYArticleDetailCell.identifier)
        self.collectionView.snp_makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }

        self.toolBar = WLYArticleDetailToolBarView()
        self.view.addSubview(self.toolBar)
        self.toolBar.snp_makeConstraints { (make) in
            make.left.right.bottom.equalTo(self.view)
            make.height.equalTo(ToolViewHeight)
        }
    }
    
    func bindAction() {
        self.toolBar.backButton.addTarget(self, action: #selector(popViewController), forControlEvents: .TouchUpInside)
    }
    
    func scrollCollectionViewToIndex(index: Int, animated: Bool) {
        let indexPath = NSIndexPath(forRow: index, inSection: 0)
        self.collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: .Top, animated: animated)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: self.view.wly_width, height: self.view.wly_height)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.articleIDs.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: WLYArticleDetailCell = collectionView.dequeueReusableCellWithReuseIdentifier(WLYArticleDetailCell.identifier, forIndexPath: indexPath) as! WLYArticleDetailCell
        
        cell.indexPath = indexPath
        cell.articleID = self.articleIDs[indexPath.row]
        
        cell.didScrollToNext = {(cell: WLYArticleDetailCell, scrollToNext: Bool) -> Void in
            let row = cell.indexPath.row + (scrollToNext ? 1 : -1)
            if row < 0 || row > self.articleIDs.count - 1 {
                return
            }
            self.scrollCollectionViewToIndex(row, animated: true)
        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
    
}