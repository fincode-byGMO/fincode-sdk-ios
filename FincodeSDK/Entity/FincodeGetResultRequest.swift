//
//  FincodeGetResultRequest.swift
//  FincodeSDK
//
//  Created by 境田真由子 on 2022/09/15.
//

import Foundation

public class FincodeGetResultRequest {
}

public class FincodeGetResultResponse: FincodeResponse {

    public let tds2TransResult: String?
    public let tds2TransResultReason: String?
    
    init(json: JSON) {
        self.tds2TransResult = json["tds2_trans_result"].string
        self.tds2TransResultReason = json["tds2_trans_result_reason"].string
    }
}
