//
//  ColorController.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/01/27.
//

import Foundation
import UIKit

class ColorController {
    
    enum ColorName: String {
        case primary = "primary"
        case radioCheckedOff = "radio_checked_off"
        case borderDefault = "border_default"
        case borderError = "border_error"
    }
    
    static let instance = ColorController()
    
    fileprivate init() {}
    
    func color(_ name: ColorName) -> UIColor {
        
        let bundle = Bundle(for: type(of: self))
        return UIColor(named: name.rawValue, in: bundle, compatibleWith: nil) ?? UIColor.clear
    }
}
