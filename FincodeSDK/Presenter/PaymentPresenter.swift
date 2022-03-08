//
//  PaymentPresenter.swift
//  fincode-ios
//
//  Created by 中嶋彰 on 2021/12/16.
//  Copyright © 2021年 GMO Payment Gateway, Inc. All rights reserved.
//

import Foundation
import UIKit

protocol PaymentPresenterDelegate: BasePresenterDelegate {
    // ViewからPresenterに委譲する処理を定義
    func cardInfoList(_ config: FincodeConfiguration)
    // PresenterからViewに通知する際のインスタンスを保持
    var viewNotify: PaymentPresenterNotify! { get set }
}

protocol PaymentPresenterNotify: AnyObject {
    // PresenterからViewに通知する処理を定義
    func cardListSuccess(_ list: [CardInfo]?)
    func cardListFailure()
    func paymentSuccess(_ result: FincodeResult)
    func paymentFailure()
}

class PaymentPresenter {
    
    weak var viewNotify: PaymentPresenterNotify!
    private let interactor: PaymentInteractorDelegate
    private let interactorCard: CardOperateInteractorDelegate
    private var mInputInfo: InputInfo?
    var externalResultDelegate: ResultDelegate?
    
    init(interactor: PaymentInteractorDelegate, interactorCard: CardOperateInteractorDelegate) {
        self.interactor = interactor
        self.interactorCard = interactorCard
    }
}

extension PaymentPresenter: PaymentPresenterDelegate {

    func cardInfoList(_ config: FincodeConfiguration) {
        guard let config = config as? FincodePaymentConfiguration else { return }
        
        let header = ApiConfiguration.instance.requestHeader(config)
        interactorCard.presenterNotify = self
        interactorCard.cardInfoList(config.customerId, header: header)
    }
    
    func execute(_ config: FincodeConfiguration, inputInfo: InputInfo) {
        guard let config = config as? FincodePaymentConfiguration else { return }
         
        let param = FincodePaymentRequest()
        param.payType = config.payType
        param.accessId = config.accessId
        param.id = config.id
        param.cardNo = inputInfo.cardNumber
        param.expire = inputInfo.expireYear + inputInfo.expireMonth
        param.securityCode = inputInfo.securityCode
        param.method = config.method
        
        let header = ApiConfiguration.instance.requestHeader(config)
        
        interactor.presenterNotify = self
        interactor.payment(config.id, request: param, header: header)
    }
}

extension PaymentPresenter: CardOperateInteractorNotify {
    
    func cardInfoListSuccess(_ result: FincodeCardInfoListResponse) {
        viewNotify.cardListSuccess(result.cardInfoList)
    }
    
    func cardRegisterSuccess(_ result: FincodeResult) {
        // no thing
    }
    
    func cardUpdateSuccess(_ result: FincodeResult) {
        // no thing
    }
    
    func cardOperateFailure() {
        viewNotify.cardListFailure()
    }
}

extension PaymentPresenter: PaymentInteractorNotify {
    
    func success(_ result: FincodeResult) {
        externalResultDelegate?.success(result)
    }
    
    func failure() {
        externalResultDelegate?.failure()
    }
}
