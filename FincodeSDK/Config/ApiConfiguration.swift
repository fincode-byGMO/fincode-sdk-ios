//
//  AppConfiguration.swift
//  fincode-ios
//
//  Created by 中嶋彰 on 2021/12/15.
//  Copyright © 2021年 GMO Payment Gateway, Inc. All rights reserved.
//

import UIKit

class ApiConfiguration {
    
    fileprivate struct Constants {
        static let contentType = "Content-Type"
        static let applicationJson = "application/json"
        static let apiVersion = "Api-Version"
        static let authorization = "Authorization"
    }
    
    static let instance = ApiConfiguration()
    let apiBaseURL: URL!
    
    init() {
        let apiBaseUrl = AppConfiguration.instance.apiBaseURL
        self.apiBaseURL = URL(string: apiBaseUrl)
    }
    
    func requestHeader(_ config: FincodeConfiguration) -> [String: String] {
        
        var header: [String: String] = [:]
        setHeader(key: Constants.contentType, value: Constants.applicationJson, header: &header)
        setHeader(key: Constants.authorization, value: config.authorizationPublic.authorization, header: &header)
        setHeader(key: Constants.apiVersion, value: config.apiVersion, header: &header)
        
        return header
    }
    
    fileprivate func setHeader(key: String, value: String?, header: inout [String: String]) {
        guard let val = value, !val.isEmpty else { return }
        header[key] = val
    }
}
