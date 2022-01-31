//
//  TextUtil.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/01/31.
//

import Foundation

class TextUtil {
    
    static func fourDigitsSpace(_ text: String) -> String {
        let value = text
        var count = 1
        var result: String = ""
        for char in value {
            result += String(char)
            if count % 4 == 0 {
                result += Constants.halfSpace
            }
            count += 1
        }
        return result
    }
    
    static func twoDigitsPaddingZero(_ text: String) -> String {
        var value = text
        if value.count == 1, value != Constants.zero {
            value.insert(Character(Constants.zero), at: value.startIndex)
            return value
        } else {
            return value
        }
    }
}
