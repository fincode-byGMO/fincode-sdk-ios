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
    public var useCase: UseCase = .none
    
    /// 認証方式およびシークレットキーを設定
    ///
    /// Basic認証 ( Base64でエンコードしたシークレットキー)
    ///
    /// Bearer認証
    public var authorizationSecret: Authorization = .Bearer(apiKey: "")
    
    /// 認証方式およびパブリックキーを設定
    ///
    /// Basic認証 ( Base64でエンコードしたパブリックキー )
    ///
    /// Bearer認証
    public var authorizationPublic: Authorization = .Bearer(apiKey: "")
    
    /// APIバージョンを設定
    public var apiVersion: String = ""
    
    /// 顧客ID
    public var customerId = ""
    
    public init() {
    }
}
