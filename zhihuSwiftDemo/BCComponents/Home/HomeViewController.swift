//
//  MainViewController.swift
//  zhihuSwiftDemo
//
//  Created by Afluy on 16/8/10.
//  Copyright © 2016年 helios. All rights reserved.
//

import Foundation
import UIKit

class HomeViewController: WLYSideMenuViewController, UITableViewDelegate {
    
    var sideMenus: Array<String>!
    
    var sideMenuView: HomeSideMenuView!
    
    override func viewDidLoad() {
        self.sideMenuView = HomeSideMenuView()
        self.leftMenuView = sideMenuView
        
        super.viewDidLoad()
        
        self.setupView()
        self.loadData()
    }
    
    func setupView() {
        self.sideMenuView.tableView.delegate = self
        
        self.showViewController(WLYArticleListViewController())
    }
    
    func loadData() {
        self.sideMenus = ["首页", "用户推荐日报", "日常心理学", "电影日报", "不许无聊", "设计日报",
                          "大公司日报", "财经日报", "互联网安全", "开始游戏", "音乐日报", "动漫日报", "体育日报"];
        self.sideMenuView.menuItems =  self.sideMenus
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("didSelectRowAtIndexPath \(self.sideMenus[indexPath.row])")
    }
}