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
    func cardUpdateSuccess(_ result: FincodeResponse)
    func cardUpdateFailure()
}

class CardUpdatePresenter {
    
    private weak var view: FincodeCommonDelegate!
    private let interactor: CardOperateInteractorDelegate
    private var mInputInfo: InputInfo?
    var externalResultDelegate: ResultDelegate?
    
    init(interactor: CardOperateInteractorDelegate, view: FincodeCommonDelegate) {
        self.interactor = interactor
        self.view = view
    }
}

extension CardUpdatePresenter: CardUpdatePresenterDelegate {

    func execute(_ config: FincodeConfiguration, inputInfo: InputInfo) {
        guard let config = config as? FincodeCardUpdateConfiguration else { return }
        
        view.showIndicator()
        let param = FincodeCardUpdateRequest()
        param.defaultFlag = config.defaultFlag.rawValue
        param.expire = (inputInfo.expireYear ?? "") + (inputInfo.expireMonth ?? "")
        param.holderName = inputInfo.holderName
        param.securityCode = inputInfo.securityCode
        
        let header = ApiConfiguration.instance.requestHeader(config)
        
        interactor.presenterNotify = self
        interactor.updateCard(config.customerId, cardId: "", request: param, header: header)
    }
}

// カード更新の結果を処理する
extension CardUpdatePresenter: CardOperateInteractorNotify {
    func cardInfoListSuccess(_ result: FincodeCardInfoListResponse) {
        // no thing
    }
    
    func cardRegisterSuccess(_ result: FincodeResponse) {
        // no thing
    }
    
    func cardUpdateSuccess(_ result: FincodeResponse) {
        view.hideIndicator()
        externalResultDelegate?.success(result)
    }
    
    func cardOperateFailure(_ useCase: CardOperateUseCase, withError error: FincodeAPIError) {
        view.hideIndicator()
        externalResultDelegate?.failure(error.errorResponse)
    }
}
