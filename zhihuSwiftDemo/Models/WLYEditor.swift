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
    var URL: NSURL?
    
    var id: Int?
    var avatar: NSURL?
    var name: String?
    var nickName: String?
    
    required init?(_ map: Map){
        
    }
    
    func mapping(map: Map) {
        URL <- (map["url"], URLTransform())
        nickName <- map["bio"]
        id <- map["id"]
        avatar <- (map["avatar"], URLTransform())
        name <- map["name"]
    }
}
