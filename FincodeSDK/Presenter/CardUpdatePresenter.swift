//
//  CardUpdatePresenter.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/02/24.
//

import Foundation
import UIKit

protocol CardUpdatePresenterDelegate: BasePresenterDelegate {
}

class CardUpdatePresenter {
    
    private let interactor: CardOperateInteractorDelegate
    private let uiview: FincodeCommon
    private var mInputInfo: InputInfo?
    var externalResultDelegate: ResultDelegate?
    
    init(interactor: CardOperateInteractorDelegate, uiview: FincodeCommon) {
        self.interactor = interactor
        self.uiview = uiview
    }
}

extension CardUpdatePresenter: CardUpdatePresenterDelegate {

    func execute(_ config: FincodeConfiguration, inputInfo: InputInfo) {
        guard let config = config as? FincodeCardUpdateConfiguration else { return }
        
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

extension CardUpdatePresenter: ResultDelegate {
    
    func success(_ result: FincodeResult) {
        if let ext = externalResultDelegate {
            ext.success(result)
        } else {
            uiview.showMessage(AppStrings.apiCardUpdateSuccessMessage.value)
        }
    }
    
    func failure() {
        if let ext = externalResultDelegate {
            ext.failure()
        } else {
            uiview.showAlert(AppStrings.apiCardUpdateFailureMessage.value)
        }
    }
}
