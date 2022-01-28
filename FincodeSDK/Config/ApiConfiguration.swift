//
//  AppConfiguration.swift
//  fincode-ios
//
//  Created by 中嶋彰 on 2021/12/15.
//  Copyright © 2021年 GMO Payment Gateway, Inc. All rights reserved.
//

import UIKit

public class ApiConfiguration {
    
    fileprivate struct Constants {
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
        setHeader(key: Constants.authorization, value: config.authorizationMethod.authorization, header: &header)
        setHeader(key: Constants.apiVersion, value: config.apiVersion, header: &header)
        
        return header
    }
    
    func orderId(_ config: FincodeConfiguration) -> String {
        return config.id
    }
    
    fileprivate func setHeader(key: String, value: String?, header: inout [String: String]) {
        guard let val = value else { return }
        header[key] = val
    }
}
