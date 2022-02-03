//
//  AppStrings.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/02/03.
//

import Foundation

enum AppStrings: String {
    
    case titleRegisteredCardRadio
    case titleNewCardRadio
    case titleRegisterCardButton
    case titleUpdateCardButton
    case titlePaymentButton
    
    case errorCardNumber
    case errorExpireMonth
    case errorExpireYear
    case errorSecurityCode
    
    var value: String {
        return NSLocalizedString(rawValue,
                                 tableName: BundleUtil.instance.bundle.infoDictionary?["CFBundleName"] as? String,
                                 bundle: BundleUtil.instance.bundle,
                                 value: "",
                                 comment: "")
    }
}
