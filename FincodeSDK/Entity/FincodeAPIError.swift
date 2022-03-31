//
//  FincodeAPIError.swift
//  fincode-ios
//
//  Created by 中嶋彰 on 2021/12/16.
//  Copyright © 2021年 GMO Payment Gateway, Inc. All rights reserved.
//

import Foundation

public class FincodeAPIError: Error {

    let errorResponse: FincodeErrorResponse

    init(response: HTTPURLResponse? = nil, data: Data? = nil) {
        
        if let statusCode = response?.statusCode, let data = data, let json = try? JSON(data: data) {
            let response = FincodeErrorResponse(statusCode, json: json)
            errorResponse = response
            logger(json)
        } else {
            errorResponse = FincodeErrorResponse()
        }
    }
}
