//
//  FincodeConfiguration.swift
//  fincode-ios
//
//  Created by 中嶋彰 on 2021/12/14.
//  Copyright © 2021年 GMO Payment Gateway, Inc. All rights reserved.
//

import Foundation

public class FincodeConfiguration {
    /// 認証方式およびAPIキー
    public var authorizationMethod: AuthorizationMethod = .none
    /// マイナーバージョン
    public var apiVersion: String = ""
    /// オーダーID
    public var id: String = ""
}
