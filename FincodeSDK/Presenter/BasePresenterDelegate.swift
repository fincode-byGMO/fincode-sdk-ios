//
//  BasePresenterDelegate.swift
//  FincodeSDK
//
//  Created by fincode on 2022/02/28.
//

import Foundation

protocol BasePresenterDelegate: AnyObject {
    var externalResultDelegate: ResultDelegate? { get set }
}
