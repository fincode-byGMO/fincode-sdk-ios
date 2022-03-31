//
//  PaymentInteractor.swift
//  fincode-ios
//
//  Created by 中嶋彰 on 2021/12/16.
//  Copyright © 2021年 GMO Payment Gateway, Inc. All rights reserved.
//

import Foundation

protocol PaymentInteractorDelegate: AnyObject {
    // PresenterからInteractorに委譲する処理を定義
    func payment(_ id: String, request: FincodePaymentRequest, header: [String: String])
    func paymentSecure(_ id: String, request: FincodePaymentSecureRequest, header: [String: String])
    // InteractorからPresenterに通知する際のインスタンスを保持
    var presenterNotify: PaymentInteractorNotify? { get set }
}

protocol PaymentInteractorNotify: AnyObject {
    // InteractorからPresenterに通知する処理を定義
    func paymentSuccess(_ result: FincodeResponse)
    func paymentSecureSuccess(_ result: FincodeResponse)
    func failure(_ useCase: PaymentUseCase, withError error: FincodeAPIError)
}

class PaymentInteractor {
 
    private let paymentUseCase = PaymentUseCase()
    var presenterNotify: PaymentInteractorNotify?
    
    init() {
        self.paymentUseCase.delegate = self
    }
    
}

extension PaymentInteractor: PaymentInteractorDelegate {
    
    func payment(_ id: String, request: FincodePaymentRequest, header: [String: String]) {
        paymentUseCase.payment(id, request: request, header: header)
    }
    
    func paymentSecure(_ id: String, request: FincodePaymentSecureRequest, header: [String : String]) {
        paymentUseCase.paymentSecure(id, request: request, header: header)
    }
}

extension PaymentInteractor: PaymentUseCaseDelegate {

    func paymentUseCase(_ useCase: PaymentUseCase, response: FincodePaymentResponse) {
        presenterNotify?.paymentSuccess(response)
    }

    func paymentSecureUseCase(_ useCase: PaymentUseCase, response: FincodePaymentSecureResponse) {
        presenterNotify?.paymentSecureSuccess(response)
    }
    
    func paymentUseCaseFaild(_ useCase: PaymentUseCase, withError error: FincodeAPIError) {
        presenterNotify?.failure(useCase, withError: error)
    }
}
