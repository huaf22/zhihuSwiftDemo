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
    var themeArray: Array<WLYArticleTheme>?
    
    var sideMenuView: HomeSideMenuView!
    var currentViewController: WLYViewController!
    
    var articleListVC: WLYArticleListViewController!
    var articleChannelListVC: WLYArticleChannelViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupView()
        self.loadData()
    }
    
    func setupView() {
        self.sideMenuView = HomeSideMenuView()
        self.sideMenuView.tableView.delegate = self
        self.showLeftView(self.sideMenuView)
        
        self.articleListVC = WLYArticleListViewController()
        self.articleChannelListVC = WLYArticleChannelViewController()
        
        self.currentViewController = self.articleListVC
        self.showViewController(currentViewController)
    }
    
    func loadData() {
        ArticleService.requestArticleThemes { (themeResult: WLYArticleThemeResult?, error: NSError?) in
            if error == nil && themeResult != nil {

                if let themeArray = themeResult?.themes {
                    var themeTitles: Array<String> = themeArray.map({ (theme: WLYArticleTheme) -> String in
                        return theme.name ?? "name"
                    })
                    
                    themeTitles.insert("首页", atIndex: 0)
                    
                    self.sideMenuView.menuItems = themeTitles
                }
                self.themeArray = themeResult?.themes
            } else {
                    //error handler
            }
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("didSelectRowAtIndexPath \(self.themeArray?[indexPath.row].name)")
        
        if indexPath.row == 0 {
            self.showViewController(self.articleListVC)
        } else {
            self.articleChannelListVC.channel = self.themeArray?[indexPath.row]
            self.showViewController(self.articleChannelListVC)
        }
    }
    
    override func childViewControllerForStatusBarStyle() -> UIViewController? {
        return self.currentViewController
    }
}