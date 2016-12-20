//
//  NotificationCenter+Extension.swift
//  zhihuSwiftDemo
//
//  Created by Afluy on 20/12/2016.
//  Copyright © 2016 helios. All rights reserved.
//

import Foundation

extension NotificationCenter {
    open func post(name: String) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: name), object: nil)
    }
}
