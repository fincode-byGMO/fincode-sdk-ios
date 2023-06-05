//
//  WebContentRouter.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/10/14.
//

import Foundation
import UIKit

protocol WebContentRouterDelegate: AnyObject {
    func backView()
}

class WebContentRouter {
    
    private unowned let viewController: UIViewController
    
    init(_ viewController: UIViewController) {
        self.viewController = viewController
    }
}

extension WebContentRouter: WebContentRouterDelegate {
    
    func backView() {
        viewController.navigationController?.popViewController(animated: true)
    }
}
