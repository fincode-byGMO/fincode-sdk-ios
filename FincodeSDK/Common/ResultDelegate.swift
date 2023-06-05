//
//  ResultDelegate.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/02/21.
//

import Foundation

@objc
public protocol ResultDelegate: AnyObject {
    @objc func success(_ result: FincodeResponse)
    @objc func failure(_ result: FincodeErrorResponse)
}
