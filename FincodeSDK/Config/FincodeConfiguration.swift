//
//  FincodeConfiguration.swift
//  fincode-ios
//
//  Created by 中嶋彰 on 2021/12/14.
//  Copyright © 2021年 GMO Payment Gateway, Inc. All rights reserved.
//

import Foundation

public class FincodeConfiguration {
    #if DEBUG
    //************** Debug向け ************** // TODO 削除予定
    /// ユースケース
    public var useCase: UseCase = .payment
    /// 認証方式およびAPIキー
    public var authorizationMethod: AuthorizationMethod = .Bearer(apiKey: "1qaz2WSX3EdC")
    /// マイナーバージョン
    public var apiVersion: String = "20220101"
    /// オーダーID
    public var id: String = "tran1234567890"
    #else
    //************** Release向け **************
    /// ユースケース
    public var useCase: UseCase = .none
    /// 認証方式およびAPIキー
    public var authorizationMethod: AuthorizationMethod = .none
    /// マイナーバージョン
    public var apiVersion: String = ""
    /// オーダーID
    public var id: String = ""
    #endif
}
