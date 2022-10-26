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
    func authentication(_ id: String, request: FincodeAuthRequest, header: [String: String])
    func getresult(_ id: String, header: [String: String])
    // InteractorからPresenterに通知する際のインスタンスを保持
    var presenterNotify: PaymentInteractorNotify? { get set }
}

protocol PaymentInteractorNotify: AnyObject {
    // InteractorからPresenterに通知する処理を定義
    func paymentSuccess(_ result: FincodeResponse)
    func paymentFailure(_ useCase: PaymentUseCase, withError error: FincodeAPIError)
    func paymentSecureSuccess(_ result: FincodeResponse)
    func paymentSecureFailure(_ useCase: PaymentUseCase, withError error: FincodeAPIError)
    func authenticationSuccess(_ result: FincodeAuthResponse)
    func authenticationFailure(_ useCase: PaymentUseCase, withError error: FincodeAPIError)
    func getresultSuccess(_ result: FincodeGetResultResponse)
    func getresultFailure(_ useCase: PaymentUseCase, withError error: FincodeAPIError)
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
    
    func authentication(_ id: String, request: FincodeAuthRequest, header: [String: String]) {
        paymentUseCase.authentication(id, request: request, header: header)
    }
    
    func getresult(_ id: String, header: [String: String]) {
        paymentUseCase.getResult(id, header: header)
    }
    
}

extension PaymentInteractor: PaymentUseCaseDelegate {
    
    func paymentUseCase(_ useCase: PaymentUseCase, response: FincodePaymentResponse) {
        presenterNotify?.paymentSuccess(response)
    }

    func paymentUseCaseFaild(_ useCase: PaymentUseCase, withError error: FincodeAPIError) {
        presenterNotify?.paymentFailure(useCase, withError: error)
    }
    
    func authenticationUseCase(_ useCase: PaymentUseCase, response: FincodeAuthResponse){
        presenterNotify?.authenticationSuccess(response)
    }

    func authenticationUseCaseFaild(_ useCase: PaymentUseCase, withError error: FincodeAPIError){
        presenterNotify?.authenticationFailure(useCase, withError: error)
    }
    
    func getResultUseCase(_ useCase: PaymentUseCase, response: FincodeGetResultResponse){
        presenterNotify?.getresultSuccess(response)
    }
    
    func getResultUseCaseFaild(_ useCase: PaymentUseCase, withError error: FincodeAPIError){
        presenterNotify?.getresultFailure(useCase, withError: error)
    }
    
    func paymentSecureUseCase(_ useCase: PaymentUseCase, response: FincodePaymentSecureResponse) {
        presenterNotify?.paymentSecureSuccess(response)
    }
    
    func paymentSecureUseCaseFaild(_ useCase: PaymentUseCase, withError error: FincodeAPIError) {
        presenterNotify?.paymentSecureFailure(useCase, withError: error)
    }
}
