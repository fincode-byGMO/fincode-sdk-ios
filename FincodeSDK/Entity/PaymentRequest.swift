//
//  PaymentRequest.swift
//  fincode-ios
//
//  Created by 中嶋彰 on 2021/12/06.
//  Copyright © 2021年 GMO Payment Gateway, Inc. All rights reserved.
//

import Foundation

public class PaymentRequest {
    
    let sample: String
    
    init(sample: String) {
        self.sample = sample
    }
    
    func parameters() -> [String: AnyObject] {
        var data: [String: AnyObject] = [:]
        data["sample"] = self.sample as AnyObject
        
        return data
    }
}

class PaymentResponse {

    let message: String?
    
    init(json: JSON) {
        let data = json["data"]
        self.message = data["message"].string
    }
}
