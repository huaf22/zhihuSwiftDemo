//
//  URLArrayTransform.swift
//  zhihuSwiftDemo
//
//  Created by Afluy on 16/8/12.
//  Copyright © 2016年 helios. All rights reserved.
//

import Foundation
import ObjectMapper

class URLArrayTransform: TransformType {
    typealias Object = Array<NSURL>
    typealias JSON = Array<AnyObject>
    
    init() {}
    
    func transformFromJSON(value: AnyObject?) -> Array<NSURL>? {
        if let URLStrings = value as? [String] {
            var listOfUrls = [NSURL]()
            for item in URLStrings {
                if let url = NSURL(string: item) {
                    listOfUrls.append(url)
                }
            }
            return listOfUrls
        }
        return nil
    }
    
    func transformToJSON(value: [NSURL]?) -> JSON? {
        if let urls = value {
            var urlStrings = [String]()
            for url in urls {
                urlStrings.append(url.absoluteString)
            }
            return urlStrings
        }
        
        return nil
    }
}