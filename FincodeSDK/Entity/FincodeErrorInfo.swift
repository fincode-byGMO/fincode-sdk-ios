//
//  FincodeErrorInfo.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/03/22.
//

import Foundation

public class FincodeErrorInfo {

    public let code: String?
    public let message: String
    
    init(json: JSON) {
        code = json["error_code"].stringValue
        message = json["error_message"].stringValue
    }
    
    init(_ message: String) {
        self.code = nil
        self.message = message
    }
}
