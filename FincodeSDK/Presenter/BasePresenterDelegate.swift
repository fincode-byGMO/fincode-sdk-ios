//
//  BasePresenterDelegate.swift
//  FincodeSDK
//
//  Created by fincode on 2022/02/28.
//

import Foundation

protocol BasePresenterDelegate: AnyObject {
    func execute(_ config: FincodeConfiguration, inputInfo: InputInfo)
}
