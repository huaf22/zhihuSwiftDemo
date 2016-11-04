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
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.scrollCollectionViewToIndex(self.currentIndex, animated: false)
    }
    
    func setupView() {
        self.automaticallyAdjustsScrollViewInsets = false
        
        let collectionViewLayout = UICollectionViewFlowLayout()
        self.collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: collectionViewLayout)
        self.view.addSubview(self.collectionView)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.isScrollEnabled = false
        self.collectionView.backgroundColor = UIColor.white
        self.collectionView.register(WLYArticleDetailCell.self, forCellWithReuseIdentifier: WLYArticleDetailCell.identifier)
        self.collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }

        self.toolBar = WLYArticleDetailToolBarView()
        self.view.addSubview(self.toolBar)
        self.toolBar.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self.view)
            make.height.equalTo(ToolViewHeight)
        }
    }
    
    func bindAction() {
        self.toolBar.backButton.addTarget(self, action: #selector(popViewController), for: .touchUpInside)
    }
    
    func scrollCollectionViewToIndex(_ index: Int, animated: Bool) {
        let indexPath = IndexPath(row: index, section: 0)
        self.collectionView.scrollToItem(at: indexPath, at: .top, animated: animated)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.wly_width, height: self.view.wly_height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.articleIDs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: WLYArticleDetailCell = collectionView.dequeueReusableCell(withReuseIdentifier: WLYArticleDetailCell.identifier, for: indexPath) as! WLYArticleDetailCell
        
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}
