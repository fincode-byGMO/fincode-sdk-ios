//
//  CardOperatePresenter.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/02/24.
//

import Foundation
import UIKit

protocol CardRegisterPresenterDelegate: BasePresenterDelegate {
}

class CardRegisterPresenter {
    
    private let interactor: CardOperateInteractorDelegate
    private let uiview: FincodeCommon
    private var mInputInfo: InputInfo?
    var externalResultDelegate: ResultDelegate?
    
    init(interactor: CardOperateInteractorDelegate, uiview: FincodeCommon) {
        self.interactor = interactor
        self.uiview = uiview
    }
}

extension CardRegisterPresenter: CardRegisterPresenterDelegate {
    
    func execute(_ config: FincodeConfiguration, inputInfo: InputInfo) {
        guard let config = config as? FincodeCardRegisterConfiguration else { return }
        
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
}

extension CardRegisterPresenter: ResultDelegate {
    
    func success(_ result: FincodeResult) {
        if let ext = externalResultDelegate {
            ext.success(result)
        } else {
            uiview.showMessage(AppStrings.apiCardRegisterSuccessMessage.value)
        }
    }
    
    func failure() {
        if let ext = externalResultDelegate {
            ext.failure()
        } else {
            uiview.showAlert(AppStrings.apiCardRegisterFailureMessage.value)
        }
    }
}
