//
//  WLYArticleCacheService.swift
//  zhihuSwiftDemo
//
//  Created by Afluy on 16/8/17.
//  Copyright © 2016年 helios. All rights reserved.
//

import Foundation

class WLYArticleCacheService {
    
    static var CachedArticleDict = Dictionary<String, Array<WLYArticle>>()     // time: [WLYArticle]
    
    static func cacheDailyArticle(_ dailyArticle: WLYDailyArticle) {
        WLYLog.i(dailyArticle.date!)
        
        WLYArticleCacheService.CachedArticleDict.updateValue(dailyArticle.articles!, forKey: dailyArticle.date!)
    }
    
    static func fetchDailyArticles(_ date: String) -> Array<WLYArticle>? {
        WLYLog.i(date)
        
        return  WLYArticleCacheService.CachedArticleDict[date]
    }
    
    
    
    static var CacheArticleDetailDict = Dictionary<String, WLYArticleDetail>() // articleID: articleDetail
    
    static func cacheArticleDetail(_ detail: WLYArticleDetail) {
        WLYLog.i("\(detail.id)")
        
        WLYArticleCacheService.CacheArticleDetailDict.updateValue(detail, forKey: "\(detail.id)")
    }
    
    static func isArticleDetailCached(_ id: String) -> Bool {
        return (WLYArticleCacheService.CacheArticleDetailDict[id] != nil)
    }
    
    static func fetchArticleDetail(_ id: String) -> WLYArticleDetail? {
        return WLYArticleCacheService.CacheArticleDetailDict[id]
    }
}
