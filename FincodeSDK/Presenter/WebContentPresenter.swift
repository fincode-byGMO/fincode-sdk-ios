//
//  WebContentPresenter.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/03/08.
//

import Foundation

import UIKit

protocol WebContentPresenterDelegate {
    // ViewからPresenterに委譲する処理を定義
   
    // PresenterからViewに通知する際のインスタンスを保持
    
}

protocol WebContentPresenterNotify: AnyObject {
    // PresenterからViewに通知する処理を定義

}

class WebContentPresenter: WebContentPresenterDelegate {  
    
    private let interactor: PaymentInteractorDelegate
    var externalResultDelegate: ResultDelegate?
    
    init(interactor: PaymentInteractorDelegate) {
        self.interactor = interactor
    }
}
