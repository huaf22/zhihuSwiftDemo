//
//  ArticleHTMLParser.swift
//  zhihuSwiftDemo
//
//  Created by Afluy on 16/8/13.
//  Copyright © 2016年 helios. All rights reserved.
//

import Foundation

class ArticleHTMLParser {
    static func parseHTML(article: WLYArticleDetail) -> String? {
        if let body = article.body {
            if let cssUrl = article.cssArray?[0] {
                let htmlString = "<html><body><link href=\"\(cssUrl)\" rel=\"stylesheet\" type=\"text/css\"/>\(body)</body><html>"
                return htmlString
            }
        }
        return nil
    }
}