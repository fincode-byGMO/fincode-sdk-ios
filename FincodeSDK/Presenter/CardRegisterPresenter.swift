//
//  CardOperatePresenter.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/02/24.
//

import Foundation
import UIKit

protocol CardRegisterPresenterDelegate: BasePresenterDelegate {
    // PresenterからViewに通知する際のインスタンスを保持
    var viewNotify: CardRegisterPresenterNotify! { get set }
}

protocol CardRegisterPresenterNotify: AnyObject {
    // PresenterからViewに通知する処理を定義
    func cardRegisterSuccess(_ result: FincodeResult)
    func cardRegisterFailure()
}

class CardRegisterPresenter {
    
    private let interactor: CardOperateInteractorDelegate
    private var mInputInfo: InputInfo?
    weak var viewNotify: CardRegisterPresenterNotify!
    
    init(interactor: CardOperateInteractorDelegate) {
        self.interactor = interactor
    }
}

extension CardRegisterPresenter: CardRegisterPresenterDelegate {
    
    func execute(_ config: FincodeConfiguration, inputInfo: InputInfo) {
        guard let config = config as? FincodeCardRegisterConfiguration else { return }
        
        let param = FincodeCardRegisterRequest()
        param.defaultFlag = config.defaultFlag.rawValue
        param.cardNo = inputInfo.cardNumber
        param.expire = inputInfo.expireYear + inputInfo.expireMonth
        param.holderName = inputInfo.holderName
        param.securityCode = inputInfo.securityCode
        param.token = config.token
        
        let header = ApiConfiguration.instance.requestHeader(config)
        
        interactor.presenterNotify = self
        interactor.registerCard(config.customerId, request: param, header: header)
    }
}

extension CardRegisterPresenter: CardOperateInteractorNotify {
    func cardInfoListSuccess(_ result: FincodeCardInfoListResponse) {
        // no thing
    }
    
    func cardRegisterSuccess(_ result: FincodeResult) {
        viewNotify?.cardRegisterSuccess(result)
    }
    
    func cardUpdateSuccess(_ result: FincodeResult) {
        // no thing
    }
    
    func cardOperateFailure() {
        viewNotify?.cardRegisterFailure()
    }
}
