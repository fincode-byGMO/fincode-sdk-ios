//
//  FincodeCardInfoListRequest.swift
//  FincodeSDK
//
//  Created by fincode on 2022/02/21.
//

import Foundation

public class FincodeCardInfoListRequest {
}

public class FincodeCardInfoListResponse {

    let cardInfoList: [CardInfo]
    
    init(json: JSON) {
        let data = json["list"]
        cardInfoList = data.arrayValue.map { CardInfo(json: $0) }
    }
}
