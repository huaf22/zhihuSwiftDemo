//
//  DispatchQueue+Extension.swift
//  zhihuSwiftDemo
//
//  Created by Afluy on 19/12/2016.
//  Copyright © 2016 helios. All rights reserved.
//

import Foundation

extension DispatchQueue {
    public func asyncAfter(time: UInt64, execute work: @escaping @convention(block) () -> Swift.Void) {
        let time = DispatchTime.now() + Double((Int64)(time * NSEC_PER_SEC)) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: time) {
            work()
        }
    }
}
