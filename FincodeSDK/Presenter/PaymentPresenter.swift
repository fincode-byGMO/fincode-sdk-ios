//
//  PaymentPresenter.swift
//  fincode-ios
//
//  Created by 中嶋彰 on 2021/12/16.
//  Copyright © 2021年 GMO Payment Gateway, Inc. All rights reserved.
//

import Foundation

protocol PaymentPresenterDelegate: BasePresenterDelegate {
    func cardInfoList(_ config: FincodeConfiguration)
}

class PaymentPresenter {
    
    private weak var view: FincodeCommonDelegate!
    private let interactor: PaymentInteractorDelegate
    private let interactorCard: CardOperateInteractorDelegate
    private let router: PaymentRouterDelegate
    private var mInputInfo: InputInfo?
    var externalResultDelegate: ResultDelegate?
    
    init(interactor: PaymentInteractorDelegate, interactorCard: CardOperateInteractorDelegate, router: PaymentRouter, view: FincodeCommonDelegate) {
        self.interactor = interactor
        self.interactorCard = interactorCard
        self.router = router
        self.view = view
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
         
        let param: FincodePaymentRequest
        switch inputInfo.useCard {
        case .registeredCard:
            param = customerIdMethod(config, inputInfo)
        case .newCard:
            param = directMethod(config, inputInfo)
        }
        
        let header = ApiConfiguration.instance.requestHeader(config)
        interactor.presenterNotify = self
        interactor.payment(config.id, request: param, header: header)
    }
    
    // 直接入力方式の場合
    private func directMethod(_ config: FincodePaymentConfiguration, _ inputInfo: InputInfo) -> FincodePaymentRequest {
        let param = FincodePaymentRequest()
        param.payType = config.payType
        param.accessId = config.accessId
        param.id = config.id
        param.cardNo = inputInfo.cardNumber
        param.expire = inputInfo.expireYear + inputInfo.expireMonth
        param.method = inputInfo.payTimes?.method
        param.payTimes = inputInfo.payTimes?.payTimes
        param.securityCode = inputInfo.securityCode
        param.holderName = inputInfo.holderName
        
        return param
    }
    
    // 顧客ID方式の場合
    private func customerIdMethod(_ config: FincodePaymentConfiguration, _ inputInfo: InputInfo) -> FincodePaymentRequest {
        let param = FincodePaymentRequest()
        param.payType = config.payType
        param.accessId = config.accessId
        param.id = config.id
        param.customerId = config.customerId
        param.cardId = inputInfo.cardId
        param.method = inputInfo.payTimes?.method
        param.payTimes = inputInfo.payTimes?.payTimes
        param.securityCode = inputInfo.securityCode
        param.holderName = inputInfo.holderName
        
        return param
    }
}

extension PaymentPresenter: CardOperateInteractorNotify {
    
    func cardInfoListSuccess(_ result: FincodeCardInfoListResponse) {
        view.setCardList(result.cardInfoList)
    }
    
    func cardRegisterSuccess(_ result: FincodeResult) {
        // no thing
    }
    
    func cardUpdateSuccess(_ result: FincodeResult) {
        // no thing
    }
    
    func cardOperateFailure() {
        // no thing
    }
}

extension PaymentPresenter: PaymentInteractorNotify {
    
    func success(_ result: FincodeResult) {
        guard let paymentResponse = result as? FincodePaymentResponse else { return }
        router.showWebView(paymentResponse)
    }
    
    func failure() {
        externalResultDelegate?.failure()
    }
}
