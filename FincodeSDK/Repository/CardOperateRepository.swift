//
//  CardOperateRepository.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/02/24.
//

import Foundation

class CardOperateRepository {
    
    static let sharedInstance = CardOperateRepository()
    
    /// カード一覧取得
    /// - Parameters:
    ///   - customerId: 顧客ID
    ///   - header: ヘッダー
    ///   - complete: 結果返却
    func cardInfoList(_ customerId: String,
                      header: [String: String],
                      complete: @escaping (_ result: APIResult<CardInfoListResponse>) -> Void)
    {
        APIEndpoint
            .cardInfoList(customer_id: customerId, header: header)
            .apiRequest
            .responseJSONWithErrorHandler
        { response in
            if response.result.isSuccess, let json = response.result.value {
                complete(.success(CardInfoListResponse(json: JSON(json))))
            } else {
                complete(.failure(APIError(response: response.response, data: response.data)))
            }
        }
    }
}
