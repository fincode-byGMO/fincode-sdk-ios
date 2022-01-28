//
//  PaymentInteractor.swift
//  fincode-ios
//
//  Created by 中嶋彰 on 2021/12/16.
//  Copyright © 2021年 GMO Payment Gateway, Inc. All rights reserved.
//

import Foundation

protocol PaymentInteractorDelegate: AnyObject {
    func payment(_ id: String, request: PaymentRequest, header: [String: String])
}

class PaymentInteractor {
 
    private var paymentUseCase = PaymentUseCase()
    
    init() {
        self.paymentUseCase.delegate = self
    }
    
}

extension PaymentInteractor: PaymentInteractorDelegate {
    
    func payment(_ id: String, request: PaymentRequest, header: [String: String]) {
        paymentUseCase.payment(id, request: request, header: header)
    }
}

extension PaymentInteractor: PaymentUseCaseDelegate {
    func paymentUseCase(_ useCase: PaymentUseCase, response: PaymentResponse) {
        // TODO API成功の実装をする
    }
    
    func paymentUseCaseFaild(_ useCase: PaymentUseCase, withError error: APIError) {
        // TODO API失敗の実装をする
    }
}
