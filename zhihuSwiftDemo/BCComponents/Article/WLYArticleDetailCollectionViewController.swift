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
    private var customView: WLYArticleDetailCollectionView!
    
    var currentIndex: Int = 0
    var articleIDs = Array<String>()
    
    // MARK:- LifeCycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        self.scrollTo(index: self.currentIndex)
    }
    
    // MARK:- Private Methods
    
    private func setupView() {
        self.automaticallyAdjustsScrollViewInsets = false
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        self.customView = WLYArticleDetailCollectionView()
        self.view.addSubview(self.customView)
        self.customView.collectionView.dataSource = self
        self.customView.collectionView.delegate = self
        self.customView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }
    
    private func bindAction() {
        self.customView.toolBar.backButton.addTarget(self, action: #selector(popViewController), for: .touchUpInside)
    }

    private func scrollTo(index: NSInteger, animated: Bool = false) {
        let indexPath = IndexPath(row: index, section: 0)
        self.customView.collectionView.scrollToItem(at: indexPath, at: .top, animated: animated)
    }
    
    // MARK:- UICollectionViewDelegate & UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.wly_width, height: collectionView.wly_height)
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
            self.scrollTo(index: row, animated: true)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // do nothing
    }
    
}
