//
//  FincodeCardUpdateRequest.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/02/28.
//

import Foundation

class FincodeCardUpdateRequest {
    
    var defaultFlag: String?
    var expire: String?
    var holderName: String?
    var securityCode: String?
    var token: String?
    
    func parameters() -> [String: AnyObject] {
        var data: [String: AnyObject] = [:]
        data["default_flag"] = defaultFlag as AnyObject
        data["expire"] = expire as AnyObject
        data["holder_name"] = holderName as AnyObject
        data["security_code"] = securityCode as AnyObject
        data["token"] = token as AnyObject
        
        return data
    }
}

public class FincodeCardUpdateResponse: FincodeResult {

    let customerId: String
    let id: String
    var defaultFlag: String
    var cardNo: String
    var expire: String
    var holderName: String?
    var cardNoHash: String
    let created: Date?
    let updated: Date?
    let type: String
    let brand: String
    
    init(json: JSON) {
        customerId = json["customer_id"].stringValue
        id = json["id"].stringValue
        defaultFlag = json["default_flag"].stringValue
        cardNo = json["card_no"].stringValue
        expire = json["expire"].stringValue
        holderName = json["holder_name"].stringValue
        cardNoHash = json["card_no_hash"].stringValue
        created = json["created"].date
        updated = json["updated"].date
        type = json["type"].stringValue
        brand = json["brand"].stringValue
    }
}
