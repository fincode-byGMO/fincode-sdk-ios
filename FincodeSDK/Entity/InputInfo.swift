//
//  InputInfo.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/02/09.
//

import Foundation

public class InputInfo {
    
    private let mCardNumber: String
    private let mExpireMonth: String
    private let mExpireYear: String
    private let mSecurityCode: String
    private let mHolderName: String?
    private let mPayTimes: String?
    
    init() {
        self.mCardNumber = ""
        self.mExpireMonth = ""
        self.mExpireYear = ""
        self.mSecurityCode = ""
        self.mHolderName = ""
        self.mPayTimes = ""
    }
    
    init(cardNumber: String, expireMonth: String, expireYear: String, securityCode: String, holderName: String?, payTimes: String?) {
        self.mCardNumber = cardNumber
        self.mExpireMonth = expireMonth
        self.mExpireYear = expireYear
        self.mSecurityCode = securityCode
        self.mHolderName = holderName
        self.mPayTimes = payTimes
    }
    
    var cardNumber: String {
        return mCardNumber
    }
    
    var expireMonth: String {
        return mExpireMonth
    }
    
    var expireYear: String {
        return mExpireYear
    }
    
    var securityCode: String {
        return mSecurityCode
    }
    
    var holderName: String? {
        return mHolderName
    }
    
    var payTimes: String? {
        return mPayTimes
    }
}
