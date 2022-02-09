//
//  FincodeConfiguration.swift
//  fincode-ios
//
//  Created by 中嶋彰 on 2021/12/14.
//  Copyright © 2021年 GMO Payment Gateway, Inc. All rights reserved.
//

import Foundation

public class FincodeConfiguration {

    /// 利用目的を選択
    ///
    /// payment : 決済
    ///
    /// registerCard : クレジットカード登録
    ///
    /// updateCard :  クレジットカード更新
    public var useCase: UseCase = .payment
    
    /// 認証方式およびAPIキーを設定
    ///
    /// Basic認証 ( Base64でエンコードしたAPIキー )
    ///
    /// Bearer認証
    public var authorizationMethod: AuthorizationMethod = .Bearer(apiKey: "")
    
    /// APIバージョンを設定
    public var apiVersion: String = ""
    
    /// 決済する対象の取引IDを設定
    public var accessId: String = ""
    
    /// オーダーIDを設定
    ///
    /// 利用目的が決済の場合、決済する対象のオーダーIDを設定
    public var id: String = ""
    
    public init() {
    }
}
