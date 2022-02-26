//
//  CardOperateUseCase.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/02/21.
//

import Foundation

protocol CardUseCaseDelegate: AnyObject {
    func CardUseCase(_ useCase: CardOperateUseCase, response: CardInfoListResponse)
    func CardUseCaseFaild(_ useCase: CardOperateUseCase, withError error: APIError)

//    func cardUseCase(_ result: APIResult<CardInfoListResponse>)
}

class CardOperateUseCase {
    weak var delegate: CardUseCaseDelegate?

    /// カード一覧取得
    /// - Parameter customerId: 顧客ID
    /// - Parameter header: ヘッダー
    func cardInfoList(_ customerId: String, header: [String: String]) {
        CardOperateRepository.sharedInstance.cardInfoList(customerId, header: header) { result in
//            self.delegate?.cardUseCase(result)
            
            switch result {
            case .success(let data):
                self.delegate?.CardUseCase(self, response: data)
            case .failure(let error):
                self.delegate?.CardUseCaseFaild(self, withError: error)
            }
        }
    }
}
