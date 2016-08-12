//
//  WLYDailyArticle.swift
//  zhihuSwiftDemo
//
//  Created by Afluy on 16/8/12.
//  Copyright © 2016年 helios. All rights reserved.
//

import Foundation
import ObjectMapper

class WLYDailyArticle: Mappable {
    var date: String?
    var articles: Array<WLYArticle>?
    
    
    required init?(_ map: Map){
        
    }
    
    func mapping(map: Map) {
        date <- map["date"]
        articles <- map["stories"]
    }
    
}
