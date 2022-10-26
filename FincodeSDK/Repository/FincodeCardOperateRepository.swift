//
//  FincodeCardOperateRepository.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/02/24.
//

import Foundation

public class FincodeCardOperateRepository {
    
    public static let sharedInstance = FincodeCardOperateRepository()
    
    /// カード一覧取得
    /// - Parameters:
    ///   - customerId: 顧客ID
    ///   - request: パラメータ
    ///   - header: ヘッダー
    ///   - complete: 結果返却
    public func cardInfoList(_ customerId: String,
                      header: [String: String],
                      complete: @escaping (_ result: FincodeApiResult<FincodeCardInfoListResponse>) -> Void)
    {
        APIEndpoint
            .cardInfoList(customerId: customerId, header: header)
            .apiRequest
            .responseJSONWithErrorHandler
        { response in
            if response.result.isSuccess, let json = response.result.value {
                complete(.success(FincodeCardInfoListResponse(json: JSON(json))))
            } else {
                complete(.failure(FincodeAPIError(response: response.response, data: response.data, errorOccurredApi: .cardInfoList)))
            }
        }
    }
    
    /// カード登録
    /// - Parameters:
    ///   - customerId: 顧客ID
    ///   - request: パラメータ
    ///   - header: ヘッダー
    ///   - complete: 結果返却
    public func registerCard(_ customerId: String,
                      request: FincodeCardRegisterRequest,
                      header: [String: String],
                      complete: @escaping (_ result: FincodeApiResult<FincodeCardRegisterResponse>) -> Void)
    {
        APIEndpoint
            .cardRegister(customerId: customerId, data: request.parameters(), header: header)
            .apiRequest
            .responseJSONWithErrorHandler
        { response in
            if response.result.isSuccess, let json = response.result.value {
                complete(.success(FincodeCardRegisterResponse(json: JSON(json))))
            } else {
                complete(.failure(FincodeAPIError(response: response.response, data: response.data, errorOccurredApi: .cardRegister)))
            }
        }
    }
    
    /// カード更新
    /// - Parameters:
    ///   - customerId: 顧客ID
    ///   - cardId: カードID
    ///   - request: パラメータ
    ///   - header: ヘッダー
    ///   - complete: 結果返却
    public func updateCard(_ customerId: String,
                    cardId: String,
                    request: FincodeCardUpdateRequest,
                    header: [String: String],
                    complete: @escaping (_ result: FincodeApiResult<FincodeCardUpdateResponse>) -> Void)
    {
        APIEndpoint
            .cardUpdate(customerId: customerId, cardId: cardId, data: request.parameters(), header: header)
            .apiRequest
            .responseJSONWithErrorHandler
        { response in
            if response.result.isSuccess, let json = response.result.value {
                complete(.success(FincodeCardUpdateResponse(json: JSON(json))))
            } else {
                complete(.failure(FincodeAPIError(response: response.response, data: response.data, errorOccurredApi: .cardUpdate)))
            }
        }
    }
}
