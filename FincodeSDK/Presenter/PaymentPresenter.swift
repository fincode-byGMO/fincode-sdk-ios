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
    private var mConfig: FincodePaymentConfiguration?
    private var mPaymentResponse: FincodePaymentResponse?
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
        
        view.showIndicator()
        let header = ApiConfiguration.instance.requestHeader(config)
        interactorCard.presenterNotify = self
        interactorCard.cardInfoList(config.customerId, header: header)
    }
    
    func execute(_ config: FincodeConfiguration, inputInfo: InputInfo) {
        guard let config = config as? FincodePaymentConfiguration else { return }
        mConfig = config
         
        view.showIndicator()
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
        param.expire = (inputInfo.expireYear ?? "") + (inputInfo.expireMonth ?? "")
        param.method = inputInfo.payTimes?.method
        param.payTimes = inputInfo.payTimes?.payTimes
        param.securityCode = inputInfo.securityCode
        param.holderName = inputInfo.holderName
        param.tds2RetUrl = config.tds2RetUrl
        param.tds2ChAccChange = config.tds2ChAccChange
        param.tds2ChAccDate = config.tds2ChAccDate
        param.tds2ChAccPwChange = config.tds2ChAccPwChange
        param.tds2NbPurchaseAccount = config.tds2NbPurchaseAccount
        param.tds2PaymentAccAge = config.tds2PaymentAccAge
        param.tds2ProvisionAttemptsDay = config.tds2ProvisionAttemptsDay
        param.tds2ShipAddressUsage = config.tds2ShipAddressUsage
        param.tds2ShipNameInd = config.tds2ShipNameInd
        param.tds2SuspiciousAccActivity = config.tds2SuspiciousAccActivity
        param.tds2TxnActivityDay = config.tds2TxnActivityDay
        param.tds2TxnActivityYear = config.tds2TxnActivityYear
        param.tds2ThreeDsReqAuthData = config.tds2ThreeDsReqAuthData
        param.tds2ThreeDsReqAuthMethod = config.tds2ThreeDsReqAuthMethod
        param.tds2ThreeDsReqAuthTimestamp = config.tds2ThreeDsReqAuthTimestamp
        param.tds2AddrMatch = config.tds2AddrMatch
        param.tds2BillAddrCity = config.tds2BillAddrCity
        param.tds2BillAddrCountry = config.tds2BillAddrCountry
        param.tds2BillAddrLine1 = config.tds2BillAddrLine1
        param.tds2BillAddrLine2 = config.tds2BillAddrLine2
        param.tds2BillAddrLine3 = config.tds2BillAddrLine3
        param.tds2BillAddrPostCode = config.tds2BillAddrPostCode
        param.tds2BillAddrState = config.tds2BillAddrState
        param.tds2Email = config.tds2Email
        param.tds2HomePhoneCc = config.tds2HomePhoneCc
        param.tds2HomePhoneNo = config.tds2HomePhoneNo
        param.tds2MobilePhoneCc = config.tds2MobilePhoneCc
        param.tds2MobilePhoneNo = config.tds2MobilePhoneNo
        param.tds2WorkPhoneCc = config.tds2WorkPhoneCc
        param.tds2WorkPhoneNo = config.tds2WorkPhoneNo
        param.tds2ShipAddrCity = config.tds2ShipAddrCity
        param.tds2ShipAddrCountry = config.tds2ShipAddrCountry
        param.tds2ShipAddrLine1 = config.tds2ShipAddrLine1
        param.tds2ShipAddrLine2 = config.tds2ShipAddrLine2
        param.tds2ShipAddrLine3 = config.tds2ShipAddrLine3
        param.tds2ShipAddrPostCode = config.tds2ShipAddrPostCode
        param.tds2ShipAddrState = config.tds2ShipAddrState
        param.tds2DeliveryEmailAddress = config.tds2DeliveryEmailAddress
        param.tds2DeliveryTimeframe = config.tds2DeliveryTimeframe
        param.tds2GiftCardAmount = config.tds2GiftCardAmount
        param.tds2GiftCardCount = config.tds2GiftCardCount
        param.tds2GiftCardCurr = config.tds2GiftCardCurr
        param.tds2PreOrderDate = config.tds2PreOrderDate
        param.tds2PreOrderPurchaseInd = config.tds2PreOrderPurchaseInd
        param.tds2ReorderItemsInd = config.tds2ReorderItemsInd
        param.tds2ReorderItemsInd = config.tds2ReorderItemsInd
        param.tds2ShipInd = config.tds2ShipInd
        param.tds2RecurringExpiry = config.tds2RecurringExpiry
        param.tds2RecurringFrequency = config.tds2RecurringFrequency
        
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
        param.tds2RetUrl = config.tds2RetUrl
        param.tds2ChAccChange = config.tds2ChAccChange
        param.tds2ChAccDate = config.tds2ChAccDate
        param.tds2ChAccPwChange = config.tds2ChAccPwChange
        param.tds2NbPurchaseAccount = config.tds2NbPurchaseAccount
        param.tds2PaymentAccAge = config.tds2PaymentAccAge
        param.tds2ProvisionAttemptsDay = config.tds2ProvisionAttemptsDay
        param.tds2ShipAddressUsage = config.tds2ShipAddressUsage
        param.tds2ShipNameInd = config.tds2ShipNameInd
        param.tds2SuspiciousAccActivity = config.tds2SuspiciousAccActivity
        param.tds2TxnActivityDay = config.tds2TxnActivityDay
        param.tds2TxnActivityYear = config.tds2TxnActivityYear
        param.tds2ThreeDsReqAuthData = config.tds2ThreeDsReqAuthData
        param.tds2ThreeDsReqAuthMethod = config.tds2ThreeDsReqAuthMethod
        param.tds2ThreeDsReqAuthTimestamp = config.tds2ThreeDsReqAuthTimestamp
        param.tds2AddrMatch = config.tds2AddrMatch
        param.tds2BillAddrCity = config.tds2BillAddrCity
        param.tds2BillAddrCountry = config.tds2BillAddrCountry
        param.tds2BillAddrLine1 = config.tds2BillAddrLine1
        param.tds2BillAddrLine2 = config.tds2BillAddrLine2
        param.tds2BillAddrLine3 = config.tds2BillAddrLine3
        param.tds2BillAddrPostCode = config.tds2BillAddrPostCode
        param.tds2BillAddrState = config.tds2BillAddrState
        param.tds2Email = config.tds2Email
        param.tds2HomePhoneCc = config.tds2HomePhoneCc
        param.tds2HomePhoneNo = config.tds2HomePhoneNo
        param.tds2MobilePhoneCc = config.tds2MobilePhoneCc
        param.tds2MobilePhoneNo = config.tds2MobilePhoneNo
        param.tds2WorkPhoneCc = config.tds2WorkPhoneCc
        param.tds2WorkPhoneNo = config.tds2WorkPhoneNo
        param.tds2ShipAddrCity = config.tds2ShipAddrCity
        param.tds2ShipAddrCountry = config.tds2ShipAddrCountry
        param.tds2ShipAddrLine1 = config.tds2ShipAddrLine1
        param.tds2ShipAddrLine2 = config.tds2ShipAddrLine2
        param.tds2ShipAddrLine3 = config.tds2ShipAddrLine3
        param.tds2ShipAddrPostCode = config.tds2ShipAddrPostCode
        param.tds2ShipAddrState = config.tds2ShipAddrState
        param.tds2DeliveryEmailAddress = config.tds2DeliveryEmailAddress
        param.tds2DeliveryTimeframe = config.tds2DeliveryTimeframe
        param.tds2GiftCardAmount = config.tds2GiftCardAmount
        param.tds2GiftCardCount = config.tds2GiftCardCount
        param.tds2GiftCardCurr = config.tds2GiftCardCurr
        param.tds2PreOrderDate = config.tds2PreOrderDate
        param.tds2PreOrderPurchaseInd = config.tds2PreOrderPurchaseInd
        param.tds2ReorderItemsInd = config.tds2ReorderItemsInd
        param.tds2ReorderItemsInd = config.tds2ReorderItemsInd
        param.tds2ShipInd = config.tds2ShipInd
        param.tds2RecurringExpiry = config.tds2RecurringExpiry
        param.tds2RecurringFrequency = config.tds2RecurringFrequency
        
        return param
    }
}

// カード一覧取得の結果を処理する
extension PaymentPresenter: CardOperateInteractorNotify {
    
    func cardInfoListSuccess(_ result: FincodeCardInfoListResponse) {
        view.hideIndicator()
        view.setCardList(result.cardInfoList)
    }
    
    func cardRegisterSuccess(_ result: FincodeResponse) {
        // no thing
    }
    
    func cardUpdateSuccess(_ result: FincodeResponse) {
        // no thing
    }
    
    func cardOperateFailure(_ useCase: CardOperateUseCase, withError error: FincodeAPIError) {
        view.hideIndicator()
    }
}

// 決済実行・認証後決済の結果を処理する
extension PaymentPresenter: PaymentInteractorNotify {
    
    func paymentSuccess(_ result: FincodeResponse) {
        guard let paymentResponse = result as? FincodePaymentResponse, let config = mConfig else { return }
        
        view.hideIndicator()
        if paymentResponse.status == "AUTHENTICATED", paymentResponse.tdsType == "2" {
            router.showWebView(paymentResponse, config: config, externalResultDelegate: externalResultDelegate)
        } else {
            externalResultDelegate?.success(result)
        }
    }
    
    func paymentFailure(_ useCase: PaymentUseCase, withError error: FincodeAPIError) {
        view.hideIndicator()
        externalResultDelegate?.failure(error.errorResponse)
    }
    
    func paymentSecureSuccess(_ result: FincodeResponse) {
        // do nothing
    }
    
    func paymentSecureFailure(_ useCase: PaymentUseCase, withError error: FincodeAPIError) {
        // do nothing
    }
    
    func authenticationSuccess(_ result: FincodeAuthResponse){
        // do nothing
    }
    
    func authenticationFailure(_ useCase: PaymentUseCase, withError error: FincodeAPIError){
        // do nothing
    }
    
    func getresultSuccess(_ result: FincodeGetResultResponse){
        // do nothing
    }
    
    func getresultFailure(_ useCase: PaymentUseCase, withError error: FincodeAPIError){
        // do nothing
    }
}
