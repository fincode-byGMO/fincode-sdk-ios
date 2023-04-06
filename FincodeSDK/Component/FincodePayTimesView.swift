//
//  FincodePayTimesView.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/03/02.
//

import Foundation
import UIKit

@IBDesignable
class FincodePayTimesView: UIView {
    
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var textField: PayTimesPickerField!
    @IBOutlet weak var textFieldConstraint: NSLayoutConstraint!
    
    var required: Bool = false
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        viewSetup()
        initialize()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        viewSetup()
        initialize()
    }
    
    fileprivate func initialize() {
        textField.isHidden = false
        textField.selectRow(0)
    }
    
    var payTimes: (method: String, payTimes: String?)? {
        
        get {
            guard let value = textField.extText else { return nil }
            
            switch(value) {
                // 一括選択時
            case 0:
                return ("1" , nil)
                // リボ
            case 1:
                return ("5", nil)
                // 分割
            case 2:
                return ("2", String(value))
                // 分割
            case 3:
                return ("2", String(value))
                // 分割
            case 5:
                return ("2", String(value))
                // 分割
            case 6:
                return ("2", String(value))
                // 分割
            case 10:
                return ("2", String(value))
                // 分割
            case 12:
                return ("2", String(value))
                // 分割
            case 15:
                return ("2", String(value))
                // 分割
            case 18:
                return ("2", String(value))
                // 分割
            case 20:
                return ("2", String(value))
                // 分割
            case 24:
                return ("2", String(value))
                
            default:
                return nil
            }
        }
    }
}

extension FincodePayTimesView: ComponentDelegate {
    
    var headingHidden: Bool {
        get {
            return headingLabel.isHidden
        }
        set {
            headingLabel.isHidden = newValue
        }
    }
    
    func validate() -> Bool {
        // do nothing
        return false
    }
    
    func clear() {
        // do nothing
    }
    
    func enabled(_ isEnabled: Bool) {
        textField.isEnabled = isEnabled
    }
}


