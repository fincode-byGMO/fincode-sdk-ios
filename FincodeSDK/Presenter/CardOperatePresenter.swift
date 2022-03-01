//
//  CardOperatePresenter.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/02/24.
//

import Foundation
import UIKit

protocol CardOperatePresenterDelegate: BasePresenterDelegate {
    func cardInfoList(_ config: FincodeConfiguration)
    func registerCard(_ config: FincodeConfiguration)
    func updateCard(_ config: FincodeConfiguration)
}

class CardOperatePresenter {
    
    private let interactor: CardOperateInteractorDelegate
    private let uiview: FincodeCommon
    private var mExternalResultDelegate: ResultDelegate?
    private var mInputInfo: InputInfo?
    
    init(interactor: CardOperateInteractorDelegate, uiview: FincodeCommon) {
        self.interactor = interactor
        self.uiview = uiview
    }
}

extension CardOperatePresenter: CardOperatePresenterDelegate {
    
    var externalResultDelegate: ResultDelegate? {
        get {
            return mExternalResultDelegate
        }
        set {
            mExternalResultDelegate = newValue
        }
    }
    
    func cardInfoList(_ config: FincodeConfiguration) {
        guard let config = config as? FincodePaymentConfiguration else { return } // TODO: 設定値がない場合はエラーハンドラを呼び出す
        
        let header = ApiConfiguration.instance.requestHeader(config)
        interactor.delegate = self
        interactor.cardInfoList(config.customerId, header: header)
    }
    
    func registerCard(_ config: FincodeConfiguration) {
        guard let config = config as? FincodeCardRegisterConfiguration else { return } // TODO: 設定値がない場合はエラーハンドラを呼び出す
        
        let param = FincodeCardRegisterRequest()
        param.defaultFlag = ""
        param.cardNo = ""
        param.expire = ""
        param.holderName = ""
        param.securityCode = ""
        param.token = ""
        
        let header = ApiConfiguration.instance.requestHeader(config)
        
        interactor.delegate = self
        interactor.registerCard(config.customerId, request: param, header: header)
    }
    
    func updateCard(_ config: FincodeConfiguration) {
        guard let config = config as? FincodeCardUpdateConfiguration else { return } // TODO: 設定値がない場合はエラーハンドラを呼び出す
        
        let param = FincodeCardUpdateRequest()
        param.defaultFlag = ""
        param.expire = ""
        param.holderName = ""
        param.securityCode = ""
        param.token = ""
        
        let header = ApiConfiguration.instance.requestHeader(config)
        
        interactor.delegate = self
        interactor.updateCard(config.customerId, cardId: "", request: param, header: header)
    }
}

extension CardOperatePresenter: ResultDelegate {
    
    func success(_ result: FincodeResult) {
        guard let response = result as? FincodeCardInfoListResponse else { return }
        uiview.setCardList(response.cardInfoList)
        //uiview.showAlert("正常", message: "")
    }
    
    func failure() {
        uiview.showAlert("異常", message: "")
    }
}
