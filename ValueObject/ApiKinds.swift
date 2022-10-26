//
//  ApiKinds.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/10/19.
//

import Foundation

public enum ApiKinds {
    
    case none
    /// 決済登録
    case register
    /// 決済実行
    case payment
    /// 3DS2.0認証実行
    case authentication
    /// 3DS2.0認証結果取得
    case getResult
    /// 認証後決済
    case paymentSecure
    /// カード登録
    case cardRegister
    /// カード更新
    case cardUpdate
    /// カード一覧取得
    case cardInfoList
}
