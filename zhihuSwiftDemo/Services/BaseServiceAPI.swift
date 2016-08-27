//
//  BaseServiceAPI.swift
//  zhihuSwiftDemo
//
//  Created by Afluy on 16/8/13.
//  Copyright © 2016年 helios. All rights reserved.
//

import Foundation

class BaseServiceAPI {
    static let APIBase = "http://news-at.zhihu.com/api/4"
    
    static let APIArticleList = APIBase + "/news/latest"
    static let APIArticleDetail = APIBase + "/news/"
    
    static let APIArticleThemes = APIBase + "/themes"
    static let APIArticleThemeDetails = APIBase + "/theme/"
}