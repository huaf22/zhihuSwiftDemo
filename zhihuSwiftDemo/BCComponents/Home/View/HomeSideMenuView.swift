//
//  HomeSideMenuView.swift
//  zhihuSwiftDemo
//
//  Created by Afluy on 16/8/10.
//  Copyright © 2016年 helios. All rights reserved.
//

import Foundation
import UIKit

class HomeSideMenuView: UIView, UITableViewDelegate, UITableViewDataSource {
    let HeaderViewHeight: CGFloat = 75
    let FooterViewHeight: CGFloat = 75
    
    var headerView: UIView!
    var footerView: UIView!
    var tableView: UITableView!
    
    var menuItems: Array<String>! {
        didSet {
            self.tableView?.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.headerView = UIView()
        self.addSubview(self.headerView)
        self.headerView.backgroundColor = UIColor.wly_backgroundColor
        self.headerView .snp_makeConstraints { (make) in
            make.left.right.top.equalTo(self)
            make.height.equalTo(HeaderViewHeight)
        }
        
        self.footerView = UIView()
        self.addSubview(self.footerView)
        self.footerView.backgroundColor = UIColor.wly_backgroundColor
        self.footerView.snp_makeConstraints { (make) in
            make.left.right.bottom.equalTo(self)
            make.height.equalTo(FooterViewHeight)
        }
        
        self.tableView = UITableView()
        self.addSubview(self.tableView)
        self.tableView.dataSource = self
        self.tableView.showsHorizontalScrollIndicator = false
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.registerClass(WLYTableViewCell.self, forCellReuseIdentifier:WLYTableViewCell.identifier)
        self.tableView.snp_makeConstraints { (make) in
            make.top.equalTo(self.headerView.snp_bottom)
            make.bottom.equalTo(self.footerView.snp_top)
            make.left.right.equalTo(self)
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(WLYTableViewCell.identifier)
        cell?.textLabel?.text = self.menuItems[indexPath.row]
        return cell!
    }
    
  
}