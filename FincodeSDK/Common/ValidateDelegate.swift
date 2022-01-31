//
//  ValidateDelegate.swift
//  FincodeSDK
//
//  Created by fincode on 2022/01/28.
//

import Foundation

protocol ValidateDelegate: AnyObject {
    func validate() -> Bool
}
