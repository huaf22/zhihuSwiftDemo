//
//  WLYArticleListViewController.swift
//  zhihuSwiftDemo
//
//  Created by Afluy on 16/7/30.
//  Copyright © 2016年 helios. All rights reserved.
//

import UIKit

class WLYArticleListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var tableView : UITableView?
    var navigationBar : WLYArticleNavigationBar?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCustomNavigation()
        loadContentViews()
    }
    
    func loadCustomNavigation() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        self.navigationBar = WLYArticleNavigationBar()
//        self.navigationBar?.title = "知乎日报"
        self.view.addSubview(self.navigationBar!)
        self.navigationBar?.snp_makeConstraints(closure: { (make) in
            make.left.right.top.equalTo(self.view)
            make.height.equalTo(44)
        })
    }
    
    func loadContentViews() {
        tableView = UITableView(frame: CGRectZero, style: UITableViewStyle.Plain)
        self.view.addSubview(tableView!)
        self.tableView?.delegate = self;
        self.tableView?.dataSource = self;
        self.tableView?.registerClass(WLYArticleTableViewCell.self , forCellReuseIdentifier: WLYArticleTableViewCell.identifier)
        self.tableView?.snp_makeConstraints(closure: { (make) in
            make.edges.equalTo(self.view).inset(UIEdgeInsets(top: 44, left: 0, bottom: 0, right: 0)) //?
        })
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20;
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50.0;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(WLYArticleTableViewCell.identifier)
        return cell!;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        NSLog("didSelectRowAtIndexPath")
    }
}


