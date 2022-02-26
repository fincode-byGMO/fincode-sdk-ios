//
//  PaymentRepository.swift
//  fincode-ios
//
//  Created by 中嶋彰 on 2021/12/06.
//  Copyright © 2021年 GMO Payment Gateway, Inc. All rights reserved.
//

import Foundation

class PaymentRepository {
    
    static let sharedInstance = PaymentRepository()
    
    /// 決済実行
    /// - Parameters:
    ///   - id: オーダーID
    ///   - request: パラメータ
    ///   - header: ヘッダー
    ///   - complete: 結果返却
    func payment(_ id: String,
                 request: PaymentRequest,
                 header: [String: String],
                 complete: @escaping (_ result: APIResult<PaymentResponse>) -> Void)
    {
        APIEndpoint
            .payment(id: id, data: request.parameters(), header: header)
            .apiRequest
            .responseJSONWithErrorHandler
        { response in
            if response.result.isSuccess, let json = response.result.value {
                complete(.success(PaymentResponse(json: JSON(json))))
            } else {
                complete(.failure(APIError(response: response.response, data: response.data)))
            }
        }
    }
    
//    /// カード一覧取得
//    /// - Parameters:
//    ///   - customerId: 顧客ID
//    ///   - header: ヘッダー
//    ///   - complete: 結果返却
//    func cardInfoList(_ customerId: String,
//                      header: [String: String],
//                      complete: @escaping (_ result: APIResult<CardInfoListResponse>) -> Void)
//    {
//        APIEndpoint
//            .cardInfoList(customer_id: customerId, header: header)
//            .apiRequest
//            .responseJSONWithErrorHandler
//        { response in
//            if response.result.isSuccess, let json = response.result.value {
//                complete(.success(CardInfoListResponse(json: JSON(json))))
//            } else {
//                complete(.failure(APIError(response: response.response, data: response.data)))
//            }
//        }
//    }
}
