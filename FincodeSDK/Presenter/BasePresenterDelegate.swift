//
//  BasePresenterDelegate.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/02/28.
//

import Foundation

protocol BasePresenterDelegate: AnyObject {
    var externalResultDelegate: ResultDelegate? { get set }
}
