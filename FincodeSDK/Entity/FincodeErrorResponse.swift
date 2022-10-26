//
//  FincodeErrorResponse.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/03/22.
//

import Foundation

public class FincodeErrorResponse {
    
    public let statusCode: Int
    public let errorOccurredApi: ApiKinds
    public let errors: [FincodeErrorInfo]
    
    init() {
        statusCode = -1
        errors = []
        errorOccurredApi = .none
    }
    
    init(_ statusCode: Int, errorOccurredApi: ApiKinds) {
        self.statusCode = statusCode
        errors = []
        self.errorOccurredApi = errorOccurredApi
    }
    
    init(_ statusCode: Int, json: JSON, errorOccurredApi: ApiKinds) {
        self.statusCode = statusCode
        errors = json["errors"].arrayValue.map { FincodeErrorInfo(json: $0) }
        self.errorOccurredApi = errorOccurredApi
    }
}
