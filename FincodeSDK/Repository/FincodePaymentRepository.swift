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
                complete(.failure(FincodeAPIError(response: response.response, data: response.data, errorOccurredApi: .payment)))
            }
        }
    }
    
    /// クレカ決済_3DS2.0認証実行
    /// - Parameters:
    ///   - id: オーダーID
    ///   - request: パラメータ
    ///   - header: ヘッダー
    ///   - complete: 結果返却
    public func authentication(_ id: String,
                               request: FincodeAuthRequest,
                               header: [String: String],
                               complete: @escaping (_ result: FincodeApiResult<FincodeAuthResponse>) -> Void)
    {
        APIEndpoint
            .authentication(id: id, data: request.parameters(), header: header)
            .apiRequest
            .responseJSONWithErrorHandler
        { response in
            if response.result.isSuccess, let json = response.result.value {
                complete(.success(FincodeAuthResponse(json: JSON(json))))
            } else {
                complete(.failure(FincodeAPIError(response: response.response, data: response.data, errorOccurredApi: .authentication)))
            }
        }
    }
    
    /// クレカ決済_3DS2.0認証結果取得
    /// - Parameters:
    ///   - id: オーダーID
    ///   - header: ヘッダー
    ///   - complete: 結果返却
    public func getResult(_ id: String,
                          header: [String: String],
                          complete: @escaping (_ result: FincodeApiResult<FincodeGetResultResponse>) -> Void)
    {
        APIEndpoint
            .getResult(id: id, header: header)
            .apiRequest
            .responseJSONWithErrorHandler
        { response in
            if response.result.isSuccess, let json = response.result.value {
                complete(.success(FincodeGetResultResponse(json: JSON(json))))
            } else {
                complete(.failure(FincodeAPIError(response: response.response, data: response.data, errorOccurredApi: .getResult)))
            }
        }
    }
    
    /// 認証後決済
    /// - Parameters:
    ///   - id: オーダーID
    ///   - request: パラメータ
    ///   - header: ヘッダー
    ///   - complete: 結果返却
    public func paymentSecure(_ id: String,
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
                complete(.failure(FincodeAPIError(response: response.response, data: response.data, errorOccurredApi: .paymentSecure)))
            }
        }
    }
}
