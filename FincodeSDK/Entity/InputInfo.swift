//
//  InputInfo.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/02/09.
//

import Foundation

public class InputInfo {
    
    private let mCardNumber: String
    private let mCardId: String?
    private let mExpireMonth: String
    private let mExpireYear: String
    private let mSecurityCode: String
    private let mHolderName: String?
    private let mPayTimes: (method: String, payTimes: String?)?
    
    init() {
        self.mCardNumber = ""
        self.mCardId = nil
        self.mExpireMonth = ""
        self.mExpireYear = ""
        self.mSecurityCode = ""
        self.mHolderName = ""
        self.mPayTimes = ("", nil)
    }
    
    init(cardNumber: String, cardId: String?, expireMonth: String, expireYear: String, securityCode: String, holderName: String?, payTimes: (method: String, payTimes: String?)?) {
        self.mCardNumber = cardNumber
        self.mCardId = cardId
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
    
    var payTimes: (method: String, payTimes: String?)? {
        return mPayTimes
    }
}
