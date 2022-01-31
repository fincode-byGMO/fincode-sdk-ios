//
//  ValidateDelegate.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/01/28.
//

import Foundation

protocol ValidateDelegate: AnyObject {
    func validate() -> Bool
}
