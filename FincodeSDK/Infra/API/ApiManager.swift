//
//  ApiManager.swift
//  fincode-ios
//
//  Created by 中嶋彰 on 2021/12/15.
//  Copyright © 2021年 GMO Payment Gateway, Inc. All rights reserved.
//

import Foundation

class ApiManager {
    static let sharedInstance: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        configuration.timeoutIntervalForRequest = 10
        return SessionManager(configuration: configuration)
    }()
}
