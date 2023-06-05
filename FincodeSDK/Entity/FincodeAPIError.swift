//
//  FincodeAPIError.swift
//  fincode-ios
//
//  Created by 中嶋彰 on 2021/12/16.
//  Copyright © 2021年 GMO Payment Gateway, Inc. All rights reserved.
//

import Foundation

public class FincodeAPIError: Error {
    
    public let errorResponse: FincodeErrorResponse
    
    init(response: HTTPURLResponse? = nil, data: Data? = nil, errorOccurredApi: ApiKinds) {
        
        if let statusCode = response?.statusCode {
            if let data = data, let json = try? JSON(data: data) {
                errorResponse = FincodeErrorResponse(statusCode, json: json, errorOccurredApi: errorOccurredApi)
                logger(json)
            } else {
                errorResponse = FincodeErrorResponse(statusCode, errorOccurredApi: errorOccurredApi)
            }
        } else {
            errorResponse = FincodeErrorResponse()
        }
    }
    
    init(_ message: String, errorOccurredApi: ApiKinds) {
        self.errorResponse = FincodeErrorResponse(message, errorOccurredApi: errorOccurredApi)
    }
}
