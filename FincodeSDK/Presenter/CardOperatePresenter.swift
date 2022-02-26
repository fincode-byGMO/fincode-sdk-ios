//
//  CardOperatePresenter.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/02/24.
//

import Foundation
import UIKit

protocol CardOperatePresenterDelegate: AnyObject {
//    var inputInfo: InputInfo? { get set }
//    var externalResultDelegate: ResultDelegate? { get set }
    func cardInfoList(_ config: FincodeConfiguration)
}

class CardOperatePresenter {
    
    private let interactor: CardOperateInteractorDelegate
    private let config: FincodeConfiguration
    private let uiview: FincodeCommon
    private var mExternalResultDelegate: ResultDelegate?
    private var mInputInfo: InputInfo?
    
    init(_ config: FincodeConfiguration, interactor: CardOperateInteractorDelegate, uiview: FincodeCommon) {
        self.config = config
        self.interactor = interactor
        self.uiview = uiview
    }
}

extension CardOperatePresenter: CardOperatePresenterDelegate {
    
    func cardInfoList(_ config: FincodeConfiguration) {
        let header = ApiConfiguration.instance.requestHeader(config)
        interactor.delegate = self
        interactor.cardInfoList(config.customerId, header: header)
    }
}

extension CardOperatePresenter: ResultDelegate {
    
    func success(_ result: FincodeResult) {
        guard let response = result as? CardInfoListResponse else { return }
        uiview.setCardList(response.cardInfoList)
        //uiview.showAlert("正常", message: "")
    }
    
    func failure() {
        uiview.showAlert("異常", message: "")
    }
}
