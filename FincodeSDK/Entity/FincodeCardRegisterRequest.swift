//
//  FincodeCardRegisterRequest.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/02/28.
//

import Foundation

class FincodeCardRegisterRequest {
    
    var defaultFlag: String?
    var cardNo: String?
    var expire: String?
    var holderName: String?
    var securityCode: String?
    var token: String?
    
    func parameters() -> [String: AnyObject] {
        var data: [String: AnyObject] = [:]
        setParam(&data, key: "default_flag", param: defaultFlag)
        setParam(&data, key: "card_no", param: cardNo)
        setParam(&data, key: "expire", param: expire)
        setParam(&data, key: "holder_name", param: holderName)
        setParam(&data, key: "security_code", param: securityCode)
        setParam(&data, key: "token", param: token)
        
        return data
    }
    
    private func setParam(_ data: inout [String: AnyObject], key: String, param: Any?) {
        if let p = param {
            data[key] = p as AnyObject
        }
    }
}

public class FincodeCardRegisterResponse: FincodeResult {

    public let customerId: String
    public let id: String
    public let defaultFlag: String
    public let cardNo: String
    public let expire: String
    public let holderName: String?
    public let cardNoHash: String
    public let created: Date?
    public let updated: Date?
    public let type: String
    public let brand: String
    
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
