//
//  CardInfo.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/01/14.
//

import Foundation

public class CardInfo {
    
    let cardNo: String
    let expire: String
    
    init(json: JSON) {
        cardNo = json["card_no"].stringValue
        expire = json["expire"].stringValue
    }
    
    // DEBUG用 削除予定
    init(_ no: String, _ ex: String) {
        cardNo = no
        expire = ex
    }
}
