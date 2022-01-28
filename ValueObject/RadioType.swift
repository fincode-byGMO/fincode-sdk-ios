//
//  RadioType.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/01/20.
//

import Foundation

enum RadioType: String {
    /// なし
    case none = ""
    /// 登録済みのカード
    case registeredCard = "registeredCard"
    /// 新しいクレジットカード
    case newCard = "newCard"
    
    var text: String {
        get {
            switch(self) {
            case .registeredCard:
                return "登録済みのカード"
            case .newCard:
                return "新しいクレジットカード"
            default:
                return ""
            }
        }
    }
}
