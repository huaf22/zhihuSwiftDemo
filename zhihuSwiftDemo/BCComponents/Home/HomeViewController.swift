//
//  MainViewController.swift
//  zhihuSwiftDemo
//
//  Created by Afluy on 16/8/10.
//  Copyright © 2016年 helios. All rights reserved.
//

import Foundation
import UIKit

class HomeViewController: WLYSideMenuViewController {

    override func viewDidLoad() {
        
        self.leftMenuView = HomeSideMenuView()
        self.mainViewController = WLYArticleListViewController()
        
        super.viewDidLoad()
    }
    
}