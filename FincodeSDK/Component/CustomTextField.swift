//
//  CustomTextField.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/01/31.
//

import Foundation
import UIKit

protocol CustomTextFieldDelegate: AnyObject {
    /// 入力確定後
    func textChanged(_ view: CustomTextField)
    /// フォーカスOUT時のバリデーション
    /// - Returns: true: 異常, false: 正常
    func valideteTextEndEditing(_ view: CustomTextField) -> Bool
}

class CustomTextField: UITextField {
    
    var customTextFieldDelegate: CustomTextFieldDelegate?
    var borderView: UIView?
    private var mMaxlength: Int = 0
    private var formatType: TextFormatType = .none
    var identifier: String?
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }

    fileprivate func initialize() {
        self.delegate = self
        self.addTarget(self, action: #selector(self.textFieldEditingChanged(_:)), for: .editingChanged)
    }
    
    private func beginEditingConvert(_ text: String) -> String {
        var value = text
        switch(formatType) {
        case .cardNumber:
            value.removeAll { $0 == Character(Constants.halfSpace) }
            return value
        case .expire:
            return value
        default:
            return value
        }
    }
    
    private func endEditingConvert(_ text: String) -> String {
        switch(formatType) {
        case .cardNumber:
            return CardBrandType.getType(text).delimit(text)
        case .expire:
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
    
    // コピー・ペースト・選択等のメニュー非表示
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return false
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
            return self.mMaxlength
        }
        set {
            self.mMaxlength = newValue
        }
    }
    
    /// TextFormatTypeの値のみを設定してください。
    /// ・カードブランドに応じた半角スペース区切りの場合: cardNumber
    /// ・0埋めの場合: expire
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
    // 1文字ごとの確定前
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if self.mMaxlength <= 0 {
            return true
        }
        
        if string.isEmpty {
            // 文字削除の場合
            return true
        }
        
        if let text = textField.text, text.count < self.mMaxlength {
            return true
        } else {
            return false
        }
    }
    
    // 1文字ごとの入力確定後
    @objc private func textFieldEditingChanged(_ sender: UITextField) {
        customTextFieldDelegate?.textChanged(self)
    }
    
    // フォーカスIN
    func textFieldDidBeginEditing(_ textField: UITextField) {
        beginEditingBorder()
        guard let text = textField.text, !text.isEmpty else { return }
        textField.text = beginEditingConvert(text)
    }
    
    // フォーカスOUT
    func textFieldDidEndEditing(_ textField: UITextField) {
        validete()
        guard let text = textField.text, !text.isEmpty else { return }
        textField.text = endEditingConvert(text)
    }
    
    func validete() -> Bool {
        guard let valid = customTextFieldDelegate else { return false }
        let isError = valid.valideteTextEndEditing(self)
        endEditingBorder(isError)
        isPlaceholderError(isError)
        
        return isError
    }
}
