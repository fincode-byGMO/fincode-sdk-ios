//
//  FincodePaymentRepository.swift
//  fincode-ios
//
//  Created by 中嶋彰 on 2021/12/06.
//  Copyright © 2021年 GMO Payment Gateway, Inc. All rights reserved.
//

import Foundation

public class FincodePaymentRepository {
    
    public static let sharedInstance = FincodePaymentRepository()
    
    /// 決済実行
    /// - Parameters:
    ///   - id: オーダーID
    ///   - request: パラメータ
    ///   - header: ヘッダー
    ///   - complete: 結果返却
    public func payment(_ id: String,
                 request: FincodePaymentRequest,
                 header: [String: String],
                 complete: @escaping (_ result: FincodeApiResult<FincodePaymentResponse>) -> Void)
    {
        APIEndpoint
            .payment(id: id, data: request.parameters(), header: header)
            .apiRequest
            .responseJSONWithErrorHandler
        { response in
            if response.result.isSuccess, let json = response.result.value {
                complete(.success(FincodePaymentResponse(json: JSON(json))))
            } else {
                complete(.failure(FincodeAPIError(response: response.response, data: response.data)))
            }
        }
    }
    
    /// 認証後決済
    /// - Parameters:
    ///   - id: オーダーID
    ///   - request: パラメータ
    ///   - header: ヘッダー
    ///   - complete: 結果返却
    public func payment(_ id: String,
                 request: FincodePaymentSecureRequest,
                 header: [String: String],
                 complete: @escaping (_ result: FincodeApiResult<FincodePaymentSecureResponse>) -> Void)
    {
        APIEndpoint
            .paymentSecure(id: id, data: request.parameters(), header: header)
            .apiRequest
            .responseJSONWithErrorHandler
        { response in
            if response.result.isSuccess, let json = response.result.value {
                complete(.success(FincodePaymentSecureResponse(json: JSON(json))))
            } else {
                complete(.failure(FincodeAPIError(response: response.response, data: response.data)))
            }
        }
    }
}
