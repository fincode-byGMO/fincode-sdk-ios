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
    func didTapPayment() throws
}

class PaymentPresenter {
    
    private weak var view: UIButton?
    private var interactor: PaymentInteractorDelegate
    var config: FincodeConfiguration = FincodeConfiguration()
    
    init(view: UIButton?, interactor: PaymentInteractorDelegate) {
        self.view = view
        self.interactor = interactor
    }
}

extension PaymentPresenter: PaymentPresenterDelegate {
    
    func didTapPayment() {
        let header = ApiConfiguration.instance.requestHeader(config)
        let id = ApiConfiguration.instance.orderId(config)
        self.interactor.payment(id, request: getRequestParam(), header: header)
    }
    
    private func getRequestParam() -> PaymentRequest {
        // TODO リクエストパラメータを実装する
        let param = PaymentRequest(sample: "")
        
        return param
    }
}
