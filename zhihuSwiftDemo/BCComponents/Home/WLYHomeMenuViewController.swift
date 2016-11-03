//
//  WLYHomeMenuViewController.swift
//  zhihuSwiftDemo
//
//  Created by Afluy on 16/8/31.
//  Copyright © 2016年 helios. All rights reserved.
//

import Foundation
import UIKit

class WLYHomeMenuViewController: WLYViewController, UITableViewDelegate, UITableViewDataSource {
    
    let HeaderViewHeight: CGFloat = 125
    let FooterViewHeight: CGFloat = 60
    
    var headerView: UIView!
    var footerView: UIView!
    var tableView: UITableView!
    
    var themeArray: Array<WLYArticleTheme>?
    
    var articleListVC: WLYArticleListViewController?
    var articleChannelVC = WLYArticleChannelViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupView()
        self.loadData()
    }
    
    func setupView() {
        self.view.backgroundColor = UIColor.wly_backgroundColor
        
        self.headerView = HomeSideMenuHeaderView()
        self.view.addSubview(self.headerView)
        self.headerView.backgroundColor = UIColor.clear
        self.headerView.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(self.view)
            make.height.equalTo(HeaderViewHeight)
        }
        
        self.footerView = HomeSideMenuFooterView()
        self.view.addSubview(self.footerView)
        self.footerView.backgroundColor = UIColor.clear
        self.footerView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self.view)
            make.height.equalTo(FooterViewHeight)
        }
        
        self.tableView = UITableView()
        self.view.addSubview(self.tableView)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.backgroundColor = UIColor.wly_backgroundColor
        self.tableView.showsHorizontalScrollIndicator = false
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.separatorColor = UIColor(rgba: "#1b2329")
        self.tableView.separatorStyle = .singleLine
        self.tableView.register(WLYTableViewCell.self, forCellReuseIdentifier:WLYTableViewCell.identifier)
        self.tableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.headerView.snp.bottom)
            make.bottom.equalTo(self.footerView.snp.top)
            make.left.right.equalTo(self.view)
        }
    }
    
    func loadData() {
        ArticleService.requestArticleThemes() { (themeResult: WLYArticleThemeResult?, error: Error?) in
            if error == nil && themeResult != nil {
                if let array = themeResult?.themes {
                    self.themeArray = array
                    self.themeArray?.insert(self.homePageTheme(), at: 0)
                    
                    self.tableView.reloadData()
                }
            } else {
                //error handler
                
            }
        }
    }
    
    func homePageTheme() -> WLYArticleTheme {
        let theme = WLYArticleTheme()
        theme.name = "首页"
        
        return  theme
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = self.themeArray?.count ?? 0
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WLYTableViewCell.identifier)
        
        cell?.selectionStyle = .none
        cell?.backgroundColor = UIColor.wly_backgroundColor
        cell?.textLabel?.textColor = UIColor.wly_darkTextColor
        cell?.textLabel?.text = self.themeArray?[indexPath.row].name ?? ""
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let parentVC = self.parent as? WLYSideMenuViewController {
            if indexPath.row == 0 {
                parentVC.showViewController(self.articleListVC!)
            } else {
                self.articleChannelVC.theme = self.themeArray?[indexPath.row]
                parentVC.showViewController(self.articleChannelVC)
            }
        }
    }
}
