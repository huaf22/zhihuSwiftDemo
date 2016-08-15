//
//  WLYArticleDetail.swift
//  zhihuSwiftDemo
//
//  Created by Afluy on 16/8/13.
//  Copyright © 2016年 helios. All rights reserved.
//

import Foundation
import ObjectMapper

class WLYArticleDetail: Mappable {
    var body: String?
    var imageSource: String?
    var title: String?
    var posterURL: NSURL?
    var shareUrl: String?
    var jsArray: Array<String>?
    var gaPrefix: String?
    var imageURLs: Array<NSURL>?
    var type: Int?
    var id: Int?
    var cssArray: Array<String>?
    
    
    required init?(_ map: Map){
        
    }
    
    func mapping(map: Map) {
        body <- map["body"]
        imageSource <- map["image_source"]
        title <- map["title"]
        posterURL <- (map["image"], URLTransform())
        shareUrl <- map["share_url"]
        jsArray <- map["js"]
        gaPrefix <- map["ga_prefix"]
        imageURLs <- (map["images"], URLArrayTransform())
        type <- map["type"]
        id <- map["id"]
        cssArray <- map["css"]
    }
}