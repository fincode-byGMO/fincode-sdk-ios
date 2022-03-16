//
//  URLRequest.swift
//  FincodeSDK
//
//  Created by fincode on 2022/03/10.
//

import Foundation

extension URLRequest {
    mutating func httpBodyForForm(_ parameters: [String: String]) {
        var list: [String] = []
        parameters.forEach { (key: String, value: String) in
            list.append(key + "=" + value)
        }
  
        self.httpBody = list.joined(separator: "&").data(using: .utf8)!
    }
}
