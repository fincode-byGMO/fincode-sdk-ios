//
//  CardBrandType.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/01/19.
//

import Foundation
import UIKit

enum CardBrandType: String {
    
    case none = ""
    case visa = "VISA"
    case master = "MASTER"
    case jcb = "JCB"
    case diners = "DINERS"
    case amex = "AMEX"
    
    init(brand: String) {
        self = type(of: self).init(rawValue: brand) ?? .none
    }
    
    init(value: String) {
        guard let visa = CardBrandType.visaRegex, let master = CardBrandType.masterRegex, let jcb = CardBrandType.jcbRegex,
              let diners = CardBrandType.dinersRegex, let amex = CardBrandType.amexRegex else {
                  self = .none
                  return
              }
        
        if 0 < visa.matches(in: value, range: NSRange(location: 0, length: value.count)).count {
            self = .visa
            return
        }
        if 0 < master.matches(in: value, range: NSRange(location: 0, length: value.count)).count {
            self = .master
            return
        }
        if 0 < jcb.matches(in: value, range: NSRange(location: 0, length: value.count)).count {
            self = .jcb
            return
        }
        if 0 < diners.matches(in: value, range: NSRange(location: 0, length: value.count)).count {
            self = .diners
            return
        }
        if 0 < amex.matches(in: value, range: NSRange(location: 0, length: value.count)).count {
            self = .amex
            return
        }
        
        self = .none
    }
    
    static private let visaRegex: NSRegularExpression? = try? NSRegularExpression(pattern: "^4[0-9]{0,15}$")
    static private let masterRegex: NSRegularExpression? = try? NSRegularExpression(pattern: "(^5[1-5][0-9]{0,14}$)|(^2[2-7][0-9]{0,14}$)")
    static private let jcbRegex: NSRegularExpression? = try? NSRegularExpression(pattern: "^35[0-9]{0,14}$")
    static private let dinersRegex: NSRegularExpression? = try? NSRegularExpression(pattern: "(^30[0-9]{0,12}$)|(^36[0-9]{0,12}$)|(^38[0-9]{0,12}$)|(^39[0-9]{0,12}$)")
    static private let amexRegex: NSRegularExpression? = try? NSRegularExpression(pattern: "(^34[0-9]{0,13}$)|(^37[0-9]{0,13}$)")
    
    func delimit(_ value: String) -> String {
        switch(self) {
        case .visa:
            return StringUtil.allFourDelimit(value)
        case .master:
            return StringUtil.allFourDelimit(value)
        case .jcb:
            return StringUtil.allFourDelimit(value)
        case .diners:
            return StringUtil.fourSixFourDelimit(value)
        case .amex:
            return StringUtil.fourSixFiveDelimit(value)
        case .none:
            return StringUtil.allFourDelimit(value)
        }
    }
    
    var cardImage: UIImage? {
        get {
            return UIImage(named: self.imageKey, in: BundleUtil.instance.bundle, compatibleWith: nil)
        }
    }
    
    var digits: Int {
        get {
            switch(self) {
            case .visa:
                return 16
            case .master:
                return 16
            case .jcb:
                return 16
            case .diners:
                return 14
            case .amex:
                return 15
            case .none:
                return 16
            }
        }
    }
    
    func validateDigits(_ value: String) -> Bool {
        if self != .none {
            return value.count != digits
        } else {
            return false
        }
    }
    
    private var imageKey: String {
        get {
            switch(self) {
            case .visa:
                return "card_visa_ic"
            case .master:
                return "card_master_ic"
            case .jcb:
                return "card_jcb_ic"
            case .diners:
                return "card_diners-club_ic"
            case .amex:
                return "card_american-xpress_ic"
            case .none:
                return ""
            }
        }
    }
}
