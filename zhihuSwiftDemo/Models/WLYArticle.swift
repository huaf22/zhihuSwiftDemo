//
//  WLYArticle.swift
//  zhihuSwiftDemo
//
//  Created by Afluy on 16/8/12.
//  Copyright © 2016年 helios. All rights reserved.
//

import Foundation
import ObjectMapper

class WLYArticle: Mappable {
    var imageURLs: Array<URL>?
    var type: Int?
    var id: Int?
    var gaPrefix: String?
    var title: String?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        imageURLs <- (map["images"], URLArrayTransform())
        type <- map["type"]
        id <- map["id"]
        gaPrefix <- map["ga_prefix"]
        title <- map["title"]
    }
    
}
