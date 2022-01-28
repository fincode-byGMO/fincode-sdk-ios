//
//  Log.swift
//  fincode-ios
//
//  Created by 中嶋彰 on 2021/12/15.
//  Copyright © 2021年 GMO Payment Gateway, Inc. All rights reserved.
//

import UIKit

class Logger {
    static func logging(_ items: [Any], function: String = #function)
    {
        #if DEBUG
            write(items.map{ String(describing: $0) }.joined(separator: "\n"), function: function)
        #endif
    }

    static fileprivate func write(_ message: String, function: String) {
        let now = Date()
        print("[\(now.stringTimestamp())] \(function): \(message)", terminator: "\n")
    }
}

func logger(_ items: Any..., function: String = #function) {
    Logger.logging(items, function: function)
}
