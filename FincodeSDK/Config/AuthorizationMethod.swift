//
//  AuthorizationMethod.swift
//  fincode-ios
//
//  Created by 中嶋彰 on 2021/12/15.
//  Copyright © 2021年 GMO Payment Gateway, Inc. All rights reserved.
//

/// 認証方式
public enum AuthorizationMethod {
    
    case none
    /// Basic認証 ( Base64でエンコードしたAPIキー )
    case Basic(apiKey: String)
    /// Bearer認証
    case Bearer(apiKey: String)
    
    var authorization: String {
        let result: String
        
        switch self {
        case .Basic(apiKey: let apiKey):
            result = "Basic \(apiKey)"
        case .Bearer(apiKey: let apiKey):
            result = "Bearer \(apiKey)"
        case .none:
            result = ""
        }
        
        return result
    }
}
