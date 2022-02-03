//
//  CustomTextField.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/01/31.
//

import Foundation
import UIKit

protocol CustomTextFieldDelegate: AnyObject {
    func customTextFieldValidate(_ view: CustomTextField) -> Bool
}

//@IBDesignable
class CustomTextField: UITextField {
    
    var validateDelegate: CustomTextFieldDelegate?
    var borderView: UIView?
    //private var borderError: Bool = false
    private var length: Int = 0
    private var formatType: TextFormatType = .none
    var identifier: String?
    
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
            return StringUtil.fourDigitsSpace(text)
        case .twoDigitsPaddingZero:
            return StringUtil.twoDigitsPaddingZero(text)
        default:
            return text
        }
    }
    
    private func beginEditingBorder() {
        var view: UIView?
        if borderView != nil {
            view = borderView
        } else {
            view = self
        }
        
        view?.isBorderFocus(true)
    }
    
    private func endEditingBorder(_ isError: Bool) {
        var view: UIView?
        if borderView != nil {
            view = borderView
        } else {
            view = self
        }
        
        if !isError {
            view?.isBorderFocus(false)
        } else {
            view?.isBorderError(true)
        }
    }
    
    override func isBorderError(_ status: Bool) {
        if let view = borderView {
            view.isBorderError(status)
        } else {
            super.isBorderError(status)
        }
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
        beginEditingBorder()
        guard let text = textField.text, !text.isEmpty else { return }
        textField.text = beginEditingConvert(text)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        validete()
        guard let text = textField.text, !text.isEmpty else { return }
        textField.text = endEditingConvert(text)
    }
    
    func validete() -> Bool {
        guard let valid = validateDelegate else { return false }
        let isError = valid.customTextFieldValidate(self)
        endEditingBorder(isError)
        isPlaceholderError(isError)
        
        return isError
    }
}
