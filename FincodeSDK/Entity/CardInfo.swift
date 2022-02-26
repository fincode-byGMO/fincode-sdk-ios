//
//  CardInfo.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/01/14.
//

import Foundation

public class CardInfo {
    
    let customerId: String
    let id: String
    let defaultFlag: String
    let cardNo: String
    let expire: String
    let holderName: String
    let cardNoHash: String
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
    
//    // DEBUG用 削除予定
//    init(_ no: String, _ ex: String) {
//        cardNo = no
//        expire = ex
//    }
}
