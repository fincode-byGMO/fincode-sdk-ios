//
//  ApiKinds.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/10/19.
//

import Foundation

public enum ApiKinds: String {
    
    case none = "none"
    /// 決済登録
    case register = "register"
    /// 決済実行
    case payment = "payment"
    /// 3DS2.0認証実行
    case authentication = "authentication"
    /// 3DS2.0認証結果取得
    case getResult = "getResult"
    /// 認証後決済
    case paymentSecure = "paymentSecure"
    /// カード登録
    case cardRegister = "cardRegister"
    /// カード更新
    case cardUpdate = "cardUpdate"
    /// カード一覧取得
    case cardInfoList = "cardInfoList"
}
