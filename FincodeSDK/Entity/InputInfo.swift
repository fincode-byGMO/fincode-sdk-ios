//
//  InputInfo.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/02/09.
//

import Foundation

class InputInfo {
    
    private let mUseCard: UseCard
    private let mCardNumber: String?
    private let mCardId: String?
    private let mExpireMonth: String?
    private let mExpireYear: String?
    private let mSecurityCode: String?
    private let mHolderName: String?
    private let mPayTimes: (method: String, payTimes: String?)?
    
    init() {
        self.mUseCard = .newCard
        self.mCardNumber = nil
        self.mCardId = nil
        self.mExpireMonth = nil
        self.mExpireYear = nil
        self.mSecurityCode = nil
        self.mHolderName = nil
        self.mPayTimes = ("", nil)
    }
    
    init(useCard: UseCard, cardNumber: String?, cardId: String?, expireMonth: String?, expireYear: String?,
         securityCode: String?, holderName: String?, payTimes: (method: String, payTimes: String?)?) {
        self.mUseCard = useCard
        self.mCardNumber = cardNumber
        self.mCardId = cardId
        self.mExpireMonth = expireMonth
        self.mExpireYear = expireYear
        self.mSecurityCode = securityCode
        self.mHolderName = holderName
        self.mPayTimes = payTimes
    }
    
    var cardId: String? {
        return mCardId
    }
    
    var useCard: UseCard {
        return mUseCard
    }
    
    var cardNumber: String? {
        return mCardNumber
    }
    
    var expireMonth: String? {
        return mExpireMonth
    }
    
    var expireYear: String? {
        return mExpireYear
    }
    
    var securityCode: String? {
        return mSecurityCode
    }
    
    var holderName: String? {
        return mHolderName
    }
    
    var payTimes: (method: String, payTimes: String?)? {
        return mPayTimes
    }
}
