//
//  URLRequest.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/03/10.
//

import Foundation

extension URLRequest {
    /// ここでURLエンコードは行っていない
    mutating func setHttpBodyForForm(_ parameters: [String: String]) {
        var list: [String] = []
        parameters.forEach { (key: String, value: String) in
            list.append(key + "=" + value)
        }
  
        self.httpBody = list.joined(separator: "&").data(using: .utf8)!
    }
    
    /// ここでURLデコードは行っていない
    mutating func getHttpBodyForForm() -> [String : String]? {
        var result: [String:String] = [:]
        if let httpBody = self.httpBody, let resBody = String(data: httpBody, encoding: .utf8) {
            let split = resBody.split(separator: "&")            
            for param in split {
                let sp = param.split(separator: "=")
                let key: String = String(sp[0])
                let value: String = String(sp[1])
                result[key] = value
            }
        }
        
        return result
    }
}
