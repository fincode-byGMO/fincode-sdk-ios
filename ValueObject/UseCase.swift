//
//  SubmitButtonType.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/01/19.
//

import Foundation

public enum UseCase: String {
    /// なし
    case none
    /// クレジットカードを登録
    case registerCard = "クレジットカードを登録"
    /// クレジットカードを更新
    case updateCard = "クレジットカードを更新"
    /// お支払い
    case payment = "お支払い"
}
