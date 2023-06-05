//
//  StringUtil.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/01/31.
//

import Foundation

class StringUtil {
        
    static func allFourDelimit(_ text: String, delimiter: String = Constants.halfSpace) -> String {
        if text.count == 16 {
            let before = String(text[text.startIndex...text.index(text.startIndex, offsetBy: 3)])
            let center1 = String(text[text.index(text.startIndex, offsetBy: 4)...text.index(text.startIndex, offsetBy: 7)])
            let center2 = String(text[text.index(text.startIndex, offsetBy: 8)...text.index(text.startIndex, offsetBy: 11)])
            let after = String(text[text.index(text.startIndex, offsetBy: 12)...text.index(text.startIndex, offsetBy: 15)])
            return [before, center1, center2, after].joined(separator: delimiter)
        } else {
            return text
        }
    }
    
    static func fourSixFourDelimit(_ text: String, delimiter: String = Constants.halfSpace) -> String {
        if text.count == 14 {
            let before = String(text[text.startIndex...text.index(text.startIndex, offsetBy: 3)])
            let center = String(text[text.index(text.startIndex, offsetBy: 4)...text.index(text.startIndex, offsetBy: 9)])
            let after = String(text[text.index(text.startIndex, offsetBy: 10)...text.index(text.startIndex, offsetBy: 13)])
            return [before, center, after].joined(separator: delimiter)
        } else {
            return text
        }
    }
    
    static func fourSixFiveDelimit(_ text: String, delimiter: String = Constants.halfSpace) -> String {
        if text.count == 15 {
            let before = String(text[text.startIndex...text.index(text.startIndex, offsetBy: 3)])
            let center = String(text[text.index(text.startIndex, offsetBy: 4)...text.index(text.startIndex, offsetBy: 9)])
            let after = String(text[text.index(text.startIndex, offsetBy: 10)...text.index(text.startIndex, offsetBy: 14)])
            return [before, center, after].joined(separator: delimiter)
        } else {
            return text
        }
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
