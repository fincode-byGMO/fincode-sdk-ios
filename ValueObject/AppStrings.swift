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
    case titlePaymentBulkRadio
    case titlePaymentDivisionRadio
    case titleRegisterCardButton
    case titleUpdateCardButton
    case titlePaymentButton
    
    case errorCardNumberFormat
    case errorCardNumber
    case errorExpireMonthFormat
    case errorExpireMonth
    case errorExpireYear
    case errorSecurityCode
    case errorHolderName
    
    case apiPaymentSuccessMessage
    case apiPaymentFailureMessage
    case apiCardRegisterSuccessMessage
    case apiCardRegisterFailureMessage
    case apiCardUpdateSuccessMessage
    case apiCardUpdateFailureMessage
    
    var value: String {
        return NSLocalizedString(rawValue,
                                 tableName: BundleUtil.instance.bundle.infoDictionary?["CFBundleName"] as? String,
                                 bundle: BundleUtil.instance.bundle,
                                 value: "",
                                 comment: "")
    }
}
