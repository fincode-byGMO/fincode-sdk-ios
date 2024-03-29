//
//  SubmitButtonType.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/01/19.
//

import Foundation

@objc
public enum SubmitButtonType: Int {
    /// なし
    case none
    /// クレジットカードを登録
    case registerCard
    /// クレジットカードを更新
    case updateCard
    /// 決済
    case payment
    
    var title: String {
        get {
            switch(self) {
            case .registerCard:
                return AppStrings.titleRegisterCardButton.value
            case .updateCard:
                return AppStrings.titleUpdateCardButton.value
            case .payment:
                return AppStrings.titlePaymentButton.value
            default:
                return ""
            }
        }
    }
}
