//
//  FcConfigurationException.swift
//  fincode-ios
//
//  Created by 中嶋彰 on 2021/12/15.
//  Copyright © 2021年 GMO Payment Gateway, Inc. All rights reserved.
//

import Foundation

struct FcConfigurationException: Error {

    let kind: ErrorKind
}

enum ErrorKind: String {
    /// リクエスト情報が設定されていません
    case configurationNotSetting = "configuration not setting"
    /// API Keyが設定されていません
    case apiKeyNotSetting = "api key not setting"
    /// レスポンスのマッピングに失敗しました
    case responseMappingFailed = "response mapping failed"
}
