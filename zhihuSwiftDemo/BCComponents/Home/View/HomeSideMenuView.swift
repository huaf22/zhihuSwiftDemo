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
    let HeaderViewHeight: CGFloat = 50;
    let FooterViewHeight: CGFloat = 50;
    
    var headerView: UIView!
    var footerView: UIView!
    var tableView: UITableView!
    
    var menuItems: Array<String>!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.loadData()
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadData() {
        self.menuItems = ["首页", "用户推荐日报", "日常心理学", "电影日报", "不许无聊", "设计日报",
                          "大公司日报", "财经日报", "互联网安全", "开始游戏", "音乐日报", "动漫日报", "体育日报"];
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
        self.tableView.delegate = self
        self.tableView.dataSource = self
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