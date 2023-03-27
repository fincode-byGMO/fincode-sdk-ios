//
//  Authorization.swift
//  fincode-ios
//
//  Created by 中嶋彰 on 2021/12/15.
//  Copyright © 2021年 GMO Payment Gateway, Inc. All rights reserved.
//

import Foundation

/// 認証方式
@objc
public enum Authorization: Int {
    
    case none
    /// Basic認証 ( Base64でエンコードしたAPIキー )
    case Basic
    /// Bearer認証
    case Bearer
        
    public func authorization(_ apiKey: String) -> String {
        let result: String
        
        switch self {
        case .Basic:
            result = "Basic \(apiKey)"
        case .Bearer:
            result = "Bearer \(apiKey)"
        case .none:
            result = ""
        }
        
        return result
    }
    
    public static func getValue(_ value: String) -> Authorization {
      if value.lowercased() == "basic" {
        return .Basic
      } else if value.lowercased() == "bearer" {
        return .Bearer
      } else {
        return .none
      }
    }
}
