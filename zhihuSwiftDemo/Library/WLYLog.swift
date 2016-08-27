//
//  WLYLog.swift
//  zhihuSwiftDemo
//
//  Created by Afluy on 16/8/17.
//  Copyright © 2016年 helios. All rights reserved.
//

import Foundation
import XCGLogger

class WLYLog {
    
    static func setup() {
        let log = XCGLogger.defaultInstance()
        log.setup(.Debug,
                  showThreadName: true,
                  showLogLevel: true,
                  showFileNames: true,
                  showLineNumbers: true,
                  writeToFile: "path/to/file",
                  fileLogLevel: .Debug)
        
    }
    
    static func i(logMessage: String) {
        XCGLogger.defaultInstance().info(logMessage)
    }
    
    static func d(logMessage: String) {
        XCGLogger.defaultInstance().debug(logMessage)
    }
    
    static func w(logMessage: String) {
        XCGLogger.defaultInstance().warning(logMessage)
    }
    
    static func e(logMessage: String) {
         XCGLogger.defaultInstance().error(logMessage)
    }
    
}