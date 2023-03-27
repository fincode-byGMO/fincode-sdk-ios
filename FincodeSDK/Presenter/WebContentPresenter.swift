//
//  WebContentPresenter.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/03/08.
//

import Foundation

protocol WebContentPresenterDelegate: BasePresenterDelegate {
    func tds2RetUrlReqHandler(body: [String:String], query: [String:String])
}

class WebContentPresenter {
   
    var interactor: PaymentInteractorDelegate?
    var router: WebContentRouterDelegate?
    var view: WebContentViewDelegate?
    
    var externalResultDelegate: ResultDelegate?
    var paymentResponse: FincodePaymentResponse?
    
    init() {
    }
}

// MARK: - notify view event to presenter

extension WebContentPresenter: WebContentPresenterDelegate{
    
    func tds2RetUrlReqHandler(body: [String:String], query: [String:String]) {
        
        guard let config = DataHolder.instance.config,
              let id = query["MD"], let param = body["param"], let event = body["event"] else { return }
        
        view?.showIndicator()
        if !(param == "Y" && event == Tds2Event.AUTH_RESULT_READY.rawValue) {
            // 3DS2.0 認証実行
            let req = FincodeAuthRequest()
            req.param = body["param"]
            let header = ApiConfiguration.instance.requestHeader(config)
            interactor?.authentication(id, request: req, header: header)
        } else {
            // 3DS2.0 認証結果取得
            let header = ApiConfiguration.instance.requestHeader(config)
            interactor?.getresult(id, header: header)
        }
    }
    
    func execute(_ config: FincodeConfiguration, inputInfo: InputInfo) {
        // do nothing
    }
}

// MARK: - notify interactor result to presenter

extension WebContentPresenter: PaymentInteractorNotify {
    
    // 決済実行
    func paymentSuccess(_ useCase: PaymentUseCase, result: FincodeResponse) {
        // do nothing
    }
    
    func paymentFailure(_ useCase: PaymentUseCase, withError error: FincodeAPIError) {
        // do nothing
    }
    
    // 3DS2.0 認証実行
    func authenticationSuccess(_ result: FincodeAuthResponse) {
        guard let config = DataHolder.instance.config else { return }
        
        if result.challengeUrl != nil {
            view?.hideIndicator()
            guard let challengeUrl = result.challengeUrl else { return }
            view?.changePage(challengeUrl)
        } else {
            guard let paymentResponse = paymentResponse, let id = paymentResponse.id else { return }
            
            let param = FincodePaymentSecureRequest()
            param.payType = paymentResponse.payType
            param.accessId = paymentResponse.accessId
            param.id = paymentResponse.id
            
            let header = ApiConfiguration.instance.requestHeader(config)
            interactor?.paymentSecure(id, request: param, header: header)
        }
    }
    
    func authenticationFailure(_ useCase: PaymentUseCase, withError error: FincodeAPIError) {
        view?.hideIndicator()
        externalResultDelegate?.failure(error.errorResponse)
    }
    
    // 3DS2.0 認証結果取得
    func getresultSuccess(_ result: FincodeGetResultResponse) {
        
        switch(result.tds2TransResult) {
        case Tds2TransResult.Y.rawValue:
            guard let paymentResponse = paymentResponse, let config = DataHolder.instance.config, let id = paymentResponse.id else { return }
            
            let param = FincodePaymentSecureRequest()
            param.payType = paymentResponse.payType
            param.accessId = paymentResponse.accessId
            param.id = paymentResponse.id
            let header = ApiConfiguration.instance.requestHeader(config)
            interactor?.paymentSecure(id, request: param, header: header)
            break;
            
        default:
            view?.hideIndicator()
            externalResultDelegate?.success(result)
            break;
        }
    }
    
    func getresultFailure(_ useCase: PaymentUseCase, withError error: FincodeAPIError) {
        view?.hideIndicator()
        externalResultDelegate?.failure(error.errorResponse)
    }
    
    // 認証後決済
    func paymentSecureSuccess(_ result: FincodeResponse) {
        view?.hideIndicator()
        router?.backView()
        externalResultDelegate?.success(result)
    }
    
    func paymentSecureFailure(_ useCase: PaymentUseCase, withError error: FincodeAPIError) {
        view?.hideIndicator()
        router?.backView()
        externalResultDelegate?.failure(error.errorResponse)
    }
}
