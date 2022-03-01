//
//  FincodeCardInfoListRequest.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/02/21.
//

import Foundation

class FincodeCardInfoListRequest {
}

class FincodeCardInfoListResponse: FincodeResult {

    let cardInfoList: [CardInfo]
    
    init(json: JSON) {
        let data = json["list"]
        cardInfoList = data.arrayValue.map { CardInfo(json: $0) }
    }
}