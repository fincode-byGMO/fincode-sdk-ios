//
//  PaymentRouter.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/03/08.
//

import Foundation
import UIKit

protocol PaymentRouterDelegate: AnyObject {
    func showWebView(_ data: FincodePaymentResponse)
}

class PaymentRouter {
    
    private unowned let viewController: UIViewController
    
    init(_ viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func nextView() -> WebContentViewController? {
        guard let view = WebContentViewController.instantiateViewControllerFromStoryboard() as? WebContentViewController else { return nil }
        let interactor = PaymentInteractor()
        let presenter = WebContentPresenter(interactor: interactor)
        view.presenter = presenter
        
        return view
    }
}

extension PaymentRouter: PaymentRouterDelegate {
    
    func showWebView(_ paymentResponse: FincodePaymentResponse) {
        guard let view = nextView() else { return }
        view.paymentResponse = paymentResponse
        viewController.navigationController?.pushViewController(view, animated: true)
    }
}
