//
//  ResultDelegate.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/02/21.
//

public protocol ResultDelegate: AnyObject {
    func success(_ result: FincodeResponse)
    func failure(_ result: FincodeErrorResponse)
}
