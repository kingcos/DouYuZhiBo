//
//  Date+Extension.swift
//  DouYuZhiBo
//
//  Created by 买明 on 24/04/2017.
//  Copyright © 2017 买明. All rights reserved.
//

import Foundation

extension Date {
    static func getCurrentMillisecond() -> String {
        return "\(Int(Date().timeIntervalSince1970))"
    }
}
