//
//  PaymentInteractor.swift
//  fincode-ios
//
//  Created by 中嶋彰 on 2021/12/16.
//  Copyright © 2021年 GMO Payment Gateway, Inc. All rights reserved.
//

import Foundation

protocol PaymentInteractorDelegate: AnyObject {
    var delegate: ResultDelegate? { get set }
    func payment(_ id: String, request: PaymentRequest, header: [String: String])
}

class PaymentInteractor {
 
    private let paymentUseCase = PaymentUseCase()
    var delegate: ResultDelegate?
    
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
//    func paymentUseCase(_ result: FincodeResult) {
//        delegate?.success(result)
//    }
    
    func paymentUseCase(_ useCase: PaymentUseCase, response: PaymentResponse) {
        // TODO API成功の実装をする
        delegate?.success(response)
    }

    func paymentUseCaseFaild(_ useCase: PaymentUseCase, withError error: APIError) {
        // TODO API失敗の実装をする
        delegate?.failure()
    }
}
