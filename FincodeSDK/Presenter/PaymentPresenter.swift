//
//  PaymentPresenter.swift
//  fincode-ios
//
//  Created by 中嶋彰 on 2021/12/16.
//  Copyright © 2021年 GMO Payment Gateway, Inc. All rights reserved.
//

import Foundation
import UIKit

protocol PaymentPresenterDelegate: AnyObject {
    var inputInfo: InputInfo? { get set }
    var externalResultDelegate: ResultDelegate? { get set }
    func payment()
}

class PaymentPresenter {
    
    private let interactor: PaymentInteractorDelegate
    private let config: FincodeConfiguration
    private let uiview: FincodeCommon
    private var mExternalResultDelegate: ResultDelegate?
    private var mInputInfo: InputInfo?
    
    init(_ config: FincodeConfiguration, interactor: PaymentInteractorDelegate, uiview: FincodeCommon) {
        self.config = config
        self.interactor = interactor
        self.uiview = uiview
    }
}

extension PaymentPresenter: PaymentPresenterDelegate {
    
    var inputInfo: InputInfo? {
        get {
            return mInputInfo
        }
        set {
            mInputInfo = newValue
        }
    }
    
    var externalResultDelegate: ResultDelegate? {
        get {
            return mExternalResultDelegate
        }
        set {
            mExternalResultDelegate = newValue
        }
    }
    
    func payment() {
        let param = PaymentRequest()
        param.payType = config.payType
        param.accessId = config.accessId
        param.id = config.id
        param.cardNo = inputInfo?.cardNumber ?? ""
        let year = inputInfo?.expireYear ?? ""
        let month = inputInfo?.expireMonth ?? ""
        param.expire = year + month
        param.securityCode = inputInfo?.securityCode ?? ""
        param.method = config.method
        
        let header = ApiConfiguration.instance.requestHeader(config)
        
        interactor.delegate = self
        interactor.payment(config.id, request: param, header: header)
    }
}

extension PaymentPresenter: ResultDelegate {
    
    func success(_ result: FincodeResult) {
        if let ext = mExternalResultDelegate {
            ext.success(result)
        } else {
            uiview.showAlert("正常", message: "")
        }
    }
    
    func failure() {
        if let ext = mExternalResultDelegate {
            ext.failure()
        } else {
            uiview.showAlert("異常", message: "")
        }
    }
}
