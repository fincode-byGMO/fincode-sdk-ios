//
//  PaymentRequest.swift
//  fincode-ios
//
//  Created by 中嶋彰 on 2021/12/06.
//  Copyright © 2021年 GMO Payment Gateway, Inc. All rights reserved.
//

import Foundation

public class PaymentRequest {
    
    var payType: String?
    var accessId: String?
    var id: String?
    var cardNo: String?
    var expire: String?
    var securityCode: String?
    var method: String?
    
    func parameters() -> [String: AnyObject] {
        var data: [String: AnyObject] = [:]
        data["pay_type"] = payType as AnyObject
        data["access_id"] = accessId as AnyObject
        data["id"] = id as AnyObject
        data["card_no"] = cardNo as AnyObject
        data["expire"] = expire as AnyObject
        data["security_code"] = securityCode as AnyObject
        data["method"] = method as AnyObject
        
        return data
    }
}

public class PaymentResponse: FincodeResult {

    let message: String?
    
    init(json: JSON) {
        let data = json["data"]
        self.message = data["message"].string
    }
}
