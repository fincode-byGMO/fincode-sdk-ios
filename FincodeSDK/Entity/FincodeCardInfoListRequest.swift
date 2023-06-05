//
//  FincodeCardInfoListRequest.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/02/21.
//

import Foundation

public class FincodeCardInfoListRequest {
}

public class FincodeCardInfoListResponse {

    public let cardInfoList: [FincodeCardInfo]
    
    init(json: JSON) {
        let data = json["list"]
        cardInfoList = data.arrayValue.map { FincodeCardInfo(json: $0) }
    }
}
