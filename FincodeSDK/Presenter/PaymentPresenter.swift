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
    func cardInfoList(_ config: FincodeConfiguration)
}

class PaymentPresenter {
    
    private let interactor: PaymentInteractorDelegate
    private let interactorCard: CardOperateInteractorDelegate
    private let uiview: FincodeCommon
    private var mInputInfo: InputInfo?
    var externalResultDelegate: ResultDelegate?
    
    init(interactor: PaymentInteractorDelegate, interactorCard: CardOperateInteractorDelegate, uiview: FincodeCommon) {
        self.interactor = interactor
        self.interactorCard = interactorCard
        self.uiview = uiview
    }
}

extension PaymentPresenter: PaymentPresenterDelegate {

    func cardInfoList(_ config: FincodeConfiguration) {
        guard let config = config as? FincodePaymentConfiguration else { return }
        
        let header = ApiConfiguration.instance.requestHeader(config)
        interactorCard.cardInfoListDelegate = self
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
        
        interactor.delegate = self
        interactor.payment(config.id, request: param, header: header)
    }
}

extension PaymentPresenter: CardInfoListDelegate {
    
    func success(_ result: FincodeCardInfoListResponse) {
        uiview.setCardList(result.cardInfoList)
    }
}

extension PaymentPresenter: ResultDelegate {
    
    func success(_ result: FincodeResult) {
        guard let ext = externalResultDelegate else { return }
        ext.success(result)
    }
    
    func failure() {
        guard let ext = externalResultDelegate else { return }
        ext.failure()
    }
}
