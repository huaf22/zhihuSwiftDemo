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

    typealias Object = Array<URL>
    typealias JSON = Array<AnyObject>
    
    init() {}
    
    public func transformFromJSON(_ value: Any?) -> Array<URL>? {
        if let URLStrings = value as? [String] {
            var listOfUrls = [URL]()
            for item in URLStrings {
                if let url = URL(string: item) {
                    listOfUrls.append(url)
                }
            }
            return listOfUrls
        }
        return nil
    }
    
    func transformToJSON(_ value: [URL]?) -> JSON? {
        if let urls = value {
            var urlStrings = [String]()
            for url in urls {
                urlStrings.append(url.absoluteString)
            }
            return urlStrings as URLArrayTransform.JSON?
        }
        
        return nil
    }
}
