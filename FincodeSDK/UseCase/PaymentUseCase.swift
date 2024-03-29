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
    func paymentUseCaseFaild(_ useCase: PaymentUseCase, withError error: FincodeAPIError)
    func authenticationUseCase(_ useCase: PaymentUseCase, response: FincodeAuthResponse)
    func authenticationUseCaseFaild(_ useCase: PaymentUseCase, withError error: FincodeAPIError)
    func getResultUseCase(_ useCase: PaymentUseCase, response: FincodeGetResultResponse)
    func getResultUseCaseFaild(_ useCase: PaymentUseCase, withError error: FincodeAPIError)
    func paymentSecureUseCase(_ useCase: PaymentUseCase, response: FincodePaymentSecureResponse)
    func paymentSecureUseCaseFaild(_ useCase: PaymentUseCase, withError error: FincodeAPIError)
}

class PaymentUseCase {
    weak var delegate: PaymentUseCaseDelegate?

    /// 決済実行
    /// - Parameter id: オーダーID
    /// - Parameter request: パラメータ
    /// - Parameter header: ヘッダー
    func payment(_ id: String, request: FincodePaymentRequest, header: [String: String]) {
        FincodePaymentRepository.sharedInstance.payment(id, request: request, header: header) { result in
            switch result {
            case .success(let data):
                self.delegate?.paymentUseCase(self, response: data)
            case .failure(let error):
                self.delegate?.paymentUseCaseFaild(self, withError: error)
            }
        }
    }
    
    /// クレカ決済_3DS2.0認証実行
    /// - Parameter id: オーダーID
    /// - Parameter request: パラメータ
    /// - Parameter header: ヘッダー
    func authentication(_ id: String, request: FincodeAuthRequest, header: [String: String]) {
        FincodePaymentRepository.sharedInstance.authentication(id, request: request, header: header) { result in
            switch result {
            case .success(let data):
                self.delegate?.authenticationUseCase(self, response: data)
            case .failure(let error):
                self.delegate?.authenticationUseCaseFaild(self, withError: error)
            }
        }
    }
    
    /// クレカ決済_3DS2.0認証結果取得
    /// - Parameter id: オーダーID
    /// - Parameter header: ヘッダー
    func getResult(_ id: String, header: [String: String]) {
        FincodePaymentRepository.sharedInstance.getResult(id, header: header) { result in
            switch result {
            case .success(let data):
                self.delegate?.getResultUseCase(self, response: data)
            case .failure(let error):
                self.delegate?.getResultUseCaseFaild(self, withError: error)
            }
        }
    }

    /// 認証後決済
    /// - Parameter id: オーダーID
    /// - Parameter request: パラメータ
    /// - Parameter header: ヘッダー
    func paymentSecure(_ id: String, request: FincodePaymentSecureRequest, header: [String: String]) {
        FincodePaymentRepository.sharedInstance.paymentSecure(id, request: request, header: header) { result in
            switch result {
            case .success(let data):
                self.delegate?.paymentSecureUseCase(self, response: data)
            case .failure(let error):
                self.delegate?.paymentSecureUseCaseFaild(self, withError: error)
            }
        }
    }
}
