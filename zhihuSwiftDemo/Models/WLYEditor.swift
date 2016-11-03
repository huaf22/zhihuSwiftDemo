//
//  WLYEditor.swift
//  zhihuSwiftDemo
//
//  Created by Afluy on 16/8/27.
//  Copyright © 2016年 helios. All rights reserved.
//

import Foundation
import ObjectMapper

class WLYEditor: Mappable {
    var URL: Foundation.URL?
    
    var id: Int?
    var avatar: Foundation.URL?
    var name: String?
    var nickName: String?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        URL <- (map["url"], URLTransform())
        nickName <- map["bio"]
        id <- map["id"]
        avatar <- (map["avatar"], URLTransform())
        name <- map["name"]
    }
}
