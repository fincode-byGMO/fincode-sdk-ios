//
//  Tds2TransResult.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/10/13.
//

import Foundation

public enum Tds2TransResult: String {
    case NONE = ""
    case Y = "Y"
    case N = "N"
    case U = "U"
    case A = "A"
    case C = "C"
    case R = "R"
    
    init(value: String) {
        self = type(of: self).init(rawValue: value) ?? .NONE
    }
}
