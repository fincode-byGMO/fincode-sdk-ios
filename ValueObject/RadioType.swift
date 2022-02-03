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
    
    var title: String {
        get {
            switch(self) {
            case .registeredCard:
                return AppStrings.titleRegisteredCardRadio.value
            case .newCard:
                return AppStrings.titleNewCardRadio.value
            default:
                return ""
            }
        }
    }
}
