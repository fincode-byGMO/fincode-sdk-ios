//
//  DefaultFlg.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/03/03.
//

import Foundation

public enum DefaultFlg: String {
    case OFF = "0"
    case ON = "1"
    
    init(value: String) {
        self = type(of: self).init(rawValue: value) ?? .OFF
    }
    
    public static func getValue(_ value: String) -> DefaultFlg {
        if value == "0" {
            return .OFF
        } else {
            return .ON
        }
    }
}
