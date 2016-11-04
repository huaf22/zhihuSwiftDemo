//
//  WLYArticleThemeResult.swift
//  zhihuSwiftDemo
//
//  Created by Afluy on 16/8/27.
//  Copyright © 2016年 helios. All rights reserved.
//

import Foundation
import ObjectMapper

class WLYArticleThemeResult: Mappable {
    var limit: Int?
    var subscribed: Array<String>?
    var themes: Array<WLYArticleTheme>?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        limit <- map["limit"]
        subscribed <- map["subscribed"]
        themes <- map["others"]
    }
}
