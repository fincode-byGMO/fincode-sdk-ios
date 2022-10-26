//
//  PaymentRouter.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/03/08.
//

import Foundation
import UIKit

protocol PaymentRouterDelegate: AnyObject {
    func showWebView(_ data: FincodePaymentResponse, config: FincodePaymentConfiguration, externalResultDelegate: ResultDelegate?)
}

class PaymentRouter {
    
    private unowned let viewController: UIViewController
    
    init(_ viewController: UIViewController) {
        self.viewController = viewController
    }
}

extension PaymentRouter: PaymentRouterDelegate {
    
    func showWebView(_ paymentResponse: FincodePaymentResponse, config: FincodePaymentConfiguration, externalResultDelegate: ResultDelegate?) {
        
        guard let view = WebContentViewController.instantiateViewControllerFromStoryboard() as? WebContentViewController else { return }
        
        let presenter = WebContentPresenter()
        let interactor = PaymentInteractor()
        
        view.url = paymentResponse.acsUrl
        view.loadUrl = .TDS2_ACS_URL
        view.config = config
        view.presenter = presenter
        
        interactor.presenterNotify = presenter
        
        presenter.interactor = interactor
        presenter.router = WebContentRouter(view)
        presenter.view = view
        
        presenter.externalResultDelegate = externalResultDelegate
        presenter.paymentResponse = paymentResponse
        
        viewController.navigationController?.pushViewController(view, animated: true)
        //view.modalPresentationStyle = .fullScreen
        //viewController.present(view, animated: true)
    }
}
