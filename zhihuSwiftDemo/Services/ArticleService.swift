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
    static func requestLatestArticles(completion: (WLYDailyArticle?, NSError?) -> Void) {
        Alamofire.request(.GET, "http://news-at.zhihu.com/api/4/news/latest", parameters: nil)
            .responseObject { (response: Response<WLYDailyArticle, NSError>) in
                switch response.result {
                case .Success:
                    if let dailyArticle = response.result.value {
                        print("dailyArticle: \(dailyArticle)")

                        completion(dailyArticle, nil)
                    }
                case .Failure(let error):
                    print(error)
                    completion(nil, error)
                }
        }
    }
}
