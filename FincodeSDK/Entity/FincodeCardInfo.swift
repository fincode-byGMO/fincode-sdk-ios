//
//  FincodeCardInfo.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/01/14.
//

import Foundation

public class FincodeCardInfo {
    
    public let customerId: String
    public let id: String
    public let defaultFlag: DefaultFlg
    public let cardNo: String
    public let expire: String
    public let holderName: String
    public let cardNoHash: String
    public let created: String
    public let updated: String
    public let type: String
    public let brand: String
    
    init(json: JSON) {
        customerId = json["customer_id"].stringValue
        id = json["id"].stringValue
        defaultFlag = DefaultFlg(value: json["default_flag"].stringValue)
        cardNo = json["card_no"].stringValue
        expire = json["expire"].stringValue
        holderName = json["holder_name"].stringValue
        cardNoHash = json["card_no_hash"].stringValue
        created = json["created"].stringValue
        updated = json["updated"].stringValue
        type = json["type"].stringValue
        brand = json["brand"].stringValue

    }
}
