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
        let log = XCGLogger.default
        log.setup(level: .debug,
                  showThreadName: true,
                  showLevel: true,
                  showFileNames: true,
                  showLineNumbers: true,
                  writeToFile: "path/to/file",
                  fileLevel: .debug)
    }
    
    static func i(_ logMessage: String) {
        XCGLogger.default.info(logMessage)
    }
    
    static func d(_ logMessage: String) {
        XCGLogger.default.debug(logMessage)
    }
    
    static func w(_ logMessage: String) {
        XCGLogger.default.warning(logMessage)
    }
    
    static func e(_ logMessage: String) {
         XCGLogger.default.error(logMessage)
    }
    
}
