//
//  PaymentUseCase.swift
//  fincode-ios
//
//  Created by 中嶋彰 on 2021/12/06.
//  Copyright © 2021年 GMO Payment Gateway, Inc. All rights reserved.
//

import Foundation

protocol PaymentUseCaseDelegate: AnyObject {
    func paymentUseCase(_ useCase: PaymentUseCase, response: FincodePaymentResponse)
    func paymentUseCaseFaild(_ useCase: PaymentUseCase, withError error: APIError)

//    func paymentUseCase(_ result: APIResult<PaymentResponse>)
}

class PaymentUseCase {
    weak var delegate: PaymentUseCaseDelegate?

    /// 決済実行
    /// - Parameter id: オーダーID
    /// - Parameter request: パラメータ
    /// - Parameter header: ヘッダー
    func payment(_ id: String, request: FincodePaymentRequest, header: [String: String]) {
        PaymentRepository.sharedInstance.payment(id, request: request, header: header) { result in
            //self.delegate?.paymentUseCase(result)
            switch result {
            case .success(let data):
                self.delegate?.paymentUseCase(self, response: data)
            case .failure(let error):
                self.delegate?.paymentUseCaseFaild(self, withError: error)
            }
        }
    }
}
