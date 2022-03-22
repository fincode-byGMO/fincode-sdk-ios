//
//  FincodeErrorResponse.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/03/22.
//

import Foundation

public class FincodeErrorResponse {
    
    public let statusCode: Int
    public let errors: [FincodeErrorInfo]
    
    init() {
        statusCode = -1
        errors = []
    }
    
    init(_ statusCode: Int, json: JSON) {
        self.statusCode = statusCode
        errors = json["errors"].arrayValue.map { FincodeErrorInfo(json: $0) }
    }
}
