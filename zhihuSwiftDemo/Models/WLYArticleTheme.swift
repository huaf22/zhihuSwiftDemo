//
//  WLYArticleTheme.swift
//  zhihuSwiftDemo
//
//  Created by Afluy on 16/8/27.
//  Copyright © 2016年 helios. All rights reserved.
//

import Foundation
import ObjectMapper

class WLYArticleTheme: Mappable {
    var colorInt: Int?
    var thumbURL: NSURL?
    var id: Int?
    var name: String?
    
    init() {
        
    }
    
    required init?(_ map: Map){
        
    }
    
    func mapping(map: Map) {
        colorInt <- map["color"]
        thumbURL <- (map["thumbnail"], URLTransform())
        id <- map["id"]
        name <- map["name"]
    }
}