//
//  ResultDelegate.swift
//  FincodeSDK
//
//  Created by fincode on 2022/02/21.
//

public protocol ResultDelegate: AnyObject {
    func success(_ result: FincodeResult)
    func failure()
}
