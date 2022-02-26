//
//  APIError.swift
//  fincode-ios
//
//  Created by 中嶋彰 on 2021/12/16.
//  Copyright © 2021年 GMO Payment Gateway, Inc. All rights reserved.
//

import Foundation

public class APIError: Error {

    enum ErrorCode: String {
        case expiredAccessToken = "expire_access_token"
        case serverError = "server_error"
        case failed = "failed"
        case networkError = "network_error"
        case unknown
    }

    // TODO エラーパラメータに修正する
    let code: ErrorCode
    let statusCode: Int
    let description: String?
    let detailMessage: String?
    let parameter: String?

    init(response: HTTPURLResponse? = nil, data: Data? = nil) {
        statusCode = response?.statusCode ?? -1

        if response == nil {
            code = .networkError
            description = nil
            detailMessage = nil
            parameter = nil
            return
        }

        guard let data = data else {
            code = .unknown
            description = nil
            detailMessage = nil
            parameter = nil
            return
        }
        
        do {
            let json = try JSON(data: data)
            code = ErrorCode(rawValue: json["error"].stringValue) ?? .unknown
            description = json["error_description"].string
            detailMessage = json["error_detail_message"].string
            parameter = json["error_parameter"].string
            
            logger("Response.data", "error : \(code)", "error_description : \(String(describing: description))", "error_detail_message : \(String(describing: detailMessage))", "error_parameter : \(String(describing: parameter))")
        } catch {
            code = .unknown
            description = nil
            detailMessage = nil
            parameter = nil
        }
    }

    init(
        code: ErrorCode,
        statusCode: Int = 0,
        description: String? = nil,
        detailMessage: String? = nil,
        parameter: String? = nil)
    {
        self.code = code
        self.statusCode = statusCode
        self.description = description
        self.detailMessage = detailMessage
        self.parameter = parameter
        
        logger("Response.data", "error : \(code)", "error_description : \(String(describing: description))", "error_detail_message : \(String(describing: detailMessage))", "error_parameter : \(String(describing: parameter))")
    }

    init(
        statusCode: Int = 0,
        description: String? = nil,
        detailMessage: String? = nil,
        parameter: String? = nil)
    {
        self.code = .expiredAccessToken
        self.statusCode = 401
        self.description = description
        self.detailMessage = detailMessage
        self.parameter = parameter
        logger("Response.data", "error : \(code)", "error_description : \(String(describing: description))", "error_detail_message : \(String(describing: detailMessage))", "error_parameter : \(String(describing: parameter))")
    }
    
//    func showErrorMessageIfOnFatalError (_ isPayment: Bool = false, action: (() -> Void)? = nil) -> Bool {
//        if self.code == .networkError {
//            return true
//        } else {
//            return true
//        }
//
//        return false
//    }

    func getErrorMessage() -> String {
        if self.code == .expiredAccessToken {
            let errorParameter = self.parameter ?? ""
            switch errorParameter {
            case "sample":
                return ""
            case "":
                return ""
            default:
                return ""
            }
        }
        
        return ""
    }

}
