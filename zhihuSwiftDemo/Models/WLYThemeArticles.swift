//
//  WLYThemeArticles.swift
//  zhihuSwiftDemo
//
//  Created by Afluy on 16/8/27.
//  Copyright © 2016年 helios. All rights reserved.
//

import Foundation
import ObjectMapper

class WLYThemeArticles: Mappable {
    var articles: Array<WLYArticle>?
    var desc: String?
    var backgroundImageURL: NSURL?
    var color: Int?
    var name: String?
    var ImageURL: NSURL?
    var editors: Array<WLYEditor>?
    var imageSource: String?
    
    required init?(_ map: Map){
        
    }
    
    func mapping(map: Map) {
        articles <- map["stories"]
        desc <- map["description"]
        backgroundImageURL <- (map["background"], URLTransform())
        color <- map["color"]
        name <- map["name"]
        ImageURL <- (map["image"], URLTransform())
        editors <- map["editors"]
        imageSource <- map["image_source"]
    }
}
