//
//  JSON.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/02/21.
//

import Foundation

extension JSON {
    
    public var date: Date? {
        get {
            switch type {
            case .string:
                if let str = object as? String {
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy/MM/dd/ HH:mm:ss.SSS"
                    //dateFormatter.timeZone = TimeZone(identifier: "Asia/Tokyo")
                    return dateFormatter.date(from: str)
                } else {
                    return nil
                }
            default:
                return nil
            }
        }
    }
}
