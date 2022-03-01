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
    ///   - request: パラメータ
    ///   - header: ヘッダー
    ///   - complete: 結果返却
    func cardInfoList(_ customerId: String,
                      header: [String: String],
                      complete: @escaping (_ result: APIResult<FincodeCardInfoListResponse>) -> Void)
    {
        APIEndpoint
            .cardInfoList(customerId: customerId, header: header)
            .apiRequest
            .responseJSONWithErrorHandler
        { response in
            if response.result.isSuccess, let json = response.result.value {
                complete(.success(FincodeCardInfoListResponse(json: JSON(json))))
            } else {
                complete(.failure(APIError(response: response.response, data: response.data)))
            }
        }
    }
    
    /// カード登録
    /// - Parameters:
    ///   - customerId: 顧客ID
    ///   - request: パラメータ
    ///   - header: ヘッダー
    ///   - complete: 結果返却
    func registerCard(_ customerId: String,
                      request: FincodeCardRegisterRequest,
                      header: [String: String],
                      complete: @escaping (_ result: APIResult<FincodeCardRegisterResponse>) -> Void)
    {
        APIEndpoint
            .cardRegister(customerId: customerId, data: request.parameters(), header: header)
            .apiRequest
            .responseJSONWithErrorHandler
        { response in
            if response.result.isSuccess, let json = response.result.value {
                complete(.success(FincodeCardRegisterResponse(json: JSON(json))))
            } else {
                complete(.failure(APIError(response: response.response, data: response.data)))
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
    func updateCard(_ customerId: String,
                    cardId: String,
                    request: FincodeCardUpdateRequest,
                    header: [String: String],
                    complete: @escaping (_ result: APIResult<FincodeCardUpdateResponse>) -> Void)
    {
        APIEndpoint
            .cardUpdate(customerId: customerId, cardId: cardId, data: request.parameters(), header: header)
            .apiRequest
            .responseJSONWithErrorHandler
        { response in
            if response.result.isSuccess, let json = response.result.value {
                complete(.success(FincodeCardUpdateResponse(json: JSON(json))))
            } else {
                complete(.failure(APIError(response: response.response, data: response.data)))
            }
        }
    }
}
