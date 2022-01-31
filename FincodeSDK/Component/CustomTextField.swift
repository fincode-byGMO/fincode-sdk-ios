//
//  CustomTextField.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/01/31.
//

import Foundation
import UIKit

//@IBDesignable
class CustomTextField: UITextField {
        
    private var length: Int = 0
    private var formatType: TextFormatType = .none
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
//        viewSetup()
        initialize()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        viewSetup()
        initialize()
    }

    fileprivate func initialize() {
        self.delegate = self
    }
    
    /// 入力可能な文字数を取得・設定
    @IBInspectable public var maxLength: Int {
        get {
            return self.length
        }
        set {
            self.length = newValue
        }
    }
    
    /// TextFormatTypeの値のみを設定してください。
    /// ・4桁ごとに半角スペース区切りの場合: fourDigitsSpace
    /// ・0埋めの場合: twoDigitsPaddingZero
    @IBInspectable public var textFormatType: String {
        get {
            return self.formatType.rawValue
        }
        set {
            self.formatType = TextFormatType(rawValue: newValue) ?? .none
        }
    }
}

extension CustomTextField: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if self.length <= 0 {
            return true
        }
        
        if string.isEmpty {
            // 文字削除の場合
            return true
        }
        
        if let text = textField.text, text.count < self.length {
            return true
        } else {
            return false
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        guard let text = textField.text, !text.isEmpty else { return }
        textField.text = beginEditingConvert(text)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text, !text.isEmpty else { return }
        textField.text = endEditingConvert(text)
    }
    
    private func beginEditingConvert(_ text: String) -> String {
        var value = text
        switch(formatType) {
        case .fourDigitsSpace:
            value.removeAll { $0 == Character(Constants.halfSpace) }
            return value
        case .twoDigitsPaddingZero:
            return value
        default:
            return value
        }
    }
    
    private func endEditingConvert(_ text: String) -> String {
        switch(formatType) {
        case .fourDigitsSpace:
            return TextUtil.fourDigitsSpace(text)
        case .twoDigitsPaddingZero:
            return TextUtil.twoDigitsPaddingZero(text)
        default:
            return text
        }
    }
}
