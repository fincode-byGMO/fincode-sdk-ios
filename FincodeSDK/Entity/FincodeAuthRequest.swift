//
//  FincodeAuthRequest.swift
//  FincodeSDK
//
//  Created by 境田真由子 on 2022/09/15.
//

import Foundation

public class FincodeAuthRequest {
    
    public var param: String?
    
    public init() {
    }
    
    func parameters() -> [String: AnyObject] {
        var data: [String: AnyObject] = [:]
        setParam(&data, key: "param", param: param)
        
        return data
    }
    
    private func setParam(_ data: inout [String: AnyObject], key: String, param: Any?) {
        if let p = param {
            data[key] = p as AnyObject
        }
    }
}

public class FincodeAuthResponse: FincodeResponse {

    public let tds2TransResult: String?
    public let tds2TransResultReason: String?
    public let challengeUrl: String?
    
    init(json: JSON) {
        self.tds2TransResult = json["tds2_trans_result"].string
        self.tds2TransResultReason = json["tds2_trans_result_reason"].string
        self.challengeUrl = json["challenge_url"].string
    }
}
