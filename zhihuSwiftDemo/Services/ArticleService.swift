//
//  ArticleService.swift
//  zhihuSwiftDemo
//
//  Created by Afluy on 16/8/12.
//  Copyright © 2016年 helios. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper
import RxSwift

class ArticleService {
    
    static func requestLatestArticles() -> Observable<WLYDailyArticle> {
        return HTTPManager.request(BaseServiceAPI.APIArticleList);
    }
    
    static func requestArticleDetail(_ id: String) -> Observable<WLYArticleDetail> {
        return HTTPManager.request(BaseServiceAPI.APIArticleDetail + id);
    }
    
    static func requestArticleThemes() -> Observable<WLYArticleThemeResult> {
        return HTTPManager.request(BaseServiceAPI.APIArticleThemes);
    }
    
    static func requestThemeArticlesWithID(_ id: Int) -> Observable<WLYThemeArticles> {
        return HTTPManager.request(BaseServiceAPI.APIArticleThemeDetails + "\(id)");
    }
}
