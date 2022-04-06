//
//  CardOperateUseCase.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/02/21.
//

import Foundation

protocol CardUseCaseDelegate: AnyObject {
    func CardUseCase(_ useCase: CardOperateUseCase, response: FincodeCardInfoListResponse)
    func CardUseCase(_ useCase: CardOperateUseCase, response: FincodeCardRegisterResponse)
    func CardUseCase(_ useCase: CardOperateUseCase, response: FincodeCardUpdateResponse)
    func CardUseCaseFaild(_ useCase: CardOperateUseCase, withError error: FincodeAPIError)
}

class CardOperateUseCase {
    weak var delegate: CardUseCaseDelegate?

    /// カード一覧取得
    /// - Parameter customerId: 顧客ID
    /// - Parameter header: ヘッダー
    func cardInfoList(_ customerId: String, header: [String: String]) {
        FincodeCardOperateRepository.instance.cardInfoList(customerId, header: header) { result in
            switch result {
            case .success(let data):
                self.delegate?.CardUseCase(self, response: data)
            case .failure(let error):
                self.delegate?.CardUseCaseFaild(self, withError: error)
            }
        }
    }
    
    /// カード登録
    /// - Parameter customerId: 顧客ID
    /// - Parameter request: パラメータ
    /// - Parameter header: ヘッダー
    func registerCard(_ customerId: String, request: FincodeCardRegisterRequest, header: [String: String]) {
        FincodeCardOperateRepository.instance.registerCard(customerId, request: request, header: header) { result in
            switch result {
            case .success(let data):
                self.delegate?.CardUseCase(self, response: data)
            case .failure(let error):
                self.delegate?.CardUseCaseFaild(self, withError: error)
            }
        }
    }
    
    /// カード更新
    /// - Parameter customerId: 顧客ID
    /// - Parameter cardId: カードID
    /// - Parameter request: パラメータ
    /// - Parameter header: ヘッダー
    func updateCard(_ customerId: String, cardId: String, request: FincodeCardUpdateRequest, header: [String: String]) {
        FincodeCardOperateRepository.instance.updateCard(customerId, cardId: cardId, request: request, header: header) { result in
            switch result {
            case .success(let data):
                self.delegate?.CardUseCase(self, response: data)
            case .failure(let error):
                self.delegate?.CardUseCaseFaild(self, withError: error)
            }
        }
    }
}
