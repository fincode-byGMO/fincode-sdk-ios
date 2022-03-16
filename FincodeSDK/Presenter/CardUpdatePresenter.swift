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

protocol CardUpdatePresenterNotify: AnyObject {
    // PresenterからViewに通知する処理を定義
    func cardUpdateSuccess(_ result: FincodeResult)
    func cardUpdateFailure()
}

class CardUpdatePresenter {
    
    private let interactor: CardOperateInteractorDelegate
    private var mInputInfo: InputInfo?
    var externalResultDelegate: ResultDelegate?
    
    init(interactor: CardOperateInteractorDelegate) {
        self.interactor = interactor
    }
}

extension CardUpdatePresenter: CardUpdatePresenterDelegate {

    func execute(_ config: FincodeConfiguration, inputInfo: InputInfo) {
        guard let config = config as? FincodeCardUpdateConfiguration else { return }
        
        let param = FincodeCardUpdateRequest()
        param.defaultFlag = config.defaultFlag.rawValue
        param.expire = inputInfo.expireYear + inputInfo.expireMonth
        param.holderName = inputInfo.holderName
        param.securityCode = inputInfo.securityCode
        param.token = config.token
        
        let header = ApiConfiguration.instance.requestHeader(config)
        
        interactor.presenterNotify = self
        interactor.updateCard(config.customerId, cardId: "", request: param, header: header)
    }
}

extension CardUpdatePresenter: CardOperateInteractorNotify {
    func cardInfoListSuccess(_ result: FincodeCardInfoListResponse) {
        // no thing
    }
    
    func cardRegisterSuccess(_ result: FincodeResult) {
        // no thing
    }
    
    func cardUpdateSuccess(_ result: FincodeResult) {
        externalResultDelegate?.success(result)
    }
    
    func cardOperateFailure() {
        externalResultDelegate?.failure()
    }
}
