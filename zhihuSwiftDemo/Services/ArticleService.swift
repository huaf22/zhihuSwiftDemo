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

class ArticleService {
    static func requestLatestArticles(_ completion: @escaping (WLYDailyArticle?, Error?) -> Void) {
        Alamofire.request(BaseServiceAPI.APIArticleList)
            .responseObject { (response: DataResponse<WLYDailyArticle>) in
                switch response.result {
                case .success:
                    if let dailyArticle = response.result.value {
                        print("dailyArticle: \(dailyArticle)")
                        WLYArticleCacheService.cacheDailyArticle(dailyArticle)
                        
                        completion(dailyArticle, nil)
                    }
                case .failure(let error):
                    print(error)
                    completion(nil, error)
                }
        }
    }
    
    static func requestArticleDetail(_ id: String, completion: @escaping (WLYArticleDetail?, Error?) -> Void) {
        Alamofire.request(BaseServiceAPI.APIArticleDetail + id)
            .responseObject { (response: DataResponse<WLYArticleDetail>) in
                switch response.result {
                case .success:
                    if let articleDetail = response.result.value {
                        
                        WLYArticleCacheService.cacheArticleDetail(articleDetail)
                        
                        completion(articleDetail, nil)
                    }
                case .failure(let error):
                     completion(nil, error)
                }
        }
    }
    
    static func requestArticleThemes(_ completion: @escaping (WLYArticleThemeResult?, Error?) -> Void) {
        Alamofire.request(BaseServiceAPI.APIArticleThemes)
            .responseObject { (response: DataResponse<WLYArticleThemeResult>) in
                switch response.result {
                case .success:
                    if let themeResult = response.result.value {
                        completion(themeResult, nil)
                    }
                case .failure(let error):
                    completion(nil, error)
                }
        }
    }
    
    static func requestThemeArticlesWithID(_ id: Int, completion: @escaping (WLYThemeArticles?, Error?) -> Void ) {
        Alamofire.request(BaseServiceAPI.APIArticleThemeDetails + "\(id)")
            .responseObject { (response: DataResponse<WLYThemeArticles>) in
                switch response.result {
                case .success:
                    if let result = response.result.value {
                        completion(result, nil)
                    }
                case .failure(let error):
                    completion(nil, error)
                }
        }
    }
}
