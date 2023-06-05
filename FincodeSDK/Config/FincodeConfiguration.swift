//
//  FincodeConfiguration.swift
//  fincode-ios
//
//  Created by 中嶋彰 on 2021/12/14.
//  Copyright © 2021年 GMO Payment Gateway, Inc. All rights reserved.
//

import Foundation

@objc
public class FincodeConfiguration: NSObject {
    /// 利用目的を選択
    ///
    /// payment : 決済
    ///
    /// registerCard : クレジットカード登録
    ///
    /// updateCard :  クレジットカード更新
    @objc public var useCase: SubmitButtonType = .none
    
    /// 認証方式およびパブリックキー
    ///
    /// Basic認証 ( Base64でエンコードしたパブリックキー )
    ///
    /// Bearer認証
    @objc public var authorizationPublic: Authorization = .Bearer
    //@objc public var authorizationPublic: Authorization = .Bearer(apiKey: "")
    
    /// API キー
    @objc public var apiKey: String = ""
    
    /// APIバージョン
    @objc public var apiVersion: String = ""
    
    /// 顧客ID
    @objc public var customerId = ""
}
