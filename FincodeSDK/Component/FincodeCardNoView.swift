//
//  FincodeCardNoView.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/01/11.
//

import Foundation
import UIKit

@IBDesignable
class FincodeCardNoView: UIView {
    
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var cardNumberTextView: CustomTextField!
    @IBOutlet weak var selectCardImage: UIImageView!
    @IBOutlet weak var errorLabelView: UILabel!
    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var cardImageView: UIView!
    
    @IBOutlet weak var cardImageWidthConstraints: NSLayoutConstraint!
    
    private var mLayoutType: LayoutType = .vertical
    static private let regex: NSRegularExpression? = try? NSRegularExpression(pattern: "^[0-9]{10,16}$")
    
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
    
    private func initialize() {
        cardNumberTextView.closable()
        cardNumberTextView.borderView = borderView
        cardNumberTextView.customTextFieldDelegate = self
    }
    
    private func horizontalLayout() {
        selectCardImage.isHidden = true
        cardImageWidthConstraints.isActive = false
        cardImageView.setViewGoneHorizontal()
    }
    
    /// LayoutTypeの値のみを設定してください。
    /// ・水平配置の場合: horizontal
    /// ・垂直配置の場合: vertical
    @IBInspectable var layoutType: String {
        get {
            return mLayoutType.rawValue
        }
        set {
            mLayoutType = LayoutType(rawValue: newValue) ?? .vertical
            if mLayoutType == .horizontal {
                horizontalLayout()
            }
        }
    }
    
    var cardNumber: String {
        get {
            guard var value = cardNumberTextView.text else { return "" }
            value.removeAll { $0 == Character(Constants.halfSpace) }
            return value
        }
    }
    
    var dynamicLogDisplay: Bool {
        get {
            return selectCardImage.isHidden
        }
        set {
            selectCardImage.isHidden = newValue
        }
    }
}

extension FincodeCardNoView: ComponentDelegate {
    
    var headingHidden: Bool {
        get {
            return headingLabel.isHidden
        }
        set {
            headingLabel.isHidden = newValue
        }
    }
    
    func validate() -> Bool {
        return cardNumberTextView.validete()
    }
    
    func clear() {
        errorLabelView.isHidden = true
        cardNumberTextView.endEditingBorder(false)
        cardNumberTextView.isPlaceholderError(false)
    }
}

extension FincodeCardNoView: CustomTextFieldDelegate {
    func textChanged(_ view: CustomTextField) {
        guard let text = view.text else { return }
        let cardBrandType = CardBrandType.getType(text)
        selectCardImage.image = cardBrandType.cardImage
        view.maxLength = cardBrandType.digits
    }
    
    func valideteTextEndEditing(_ view: CustomTextField) -> Bool {
        let isError = cardNumber.isEmpty || isFormatCheck(cardNumber) || CardBrandType.getType(cardNumber).validateDigits(cardNumber)
        
        errorLabelView.text = getErrorMessage(cardNumber)
        errorLabelView.isHidden = !isError
        //setFormatErrorColor(view)
        
        return isError
    }
    
    private func setFormatErrorColor(_ view: CustomTextField) {
        guard let value = cardNumberTextView.text else { return }
        if CardBrandType.getType(value).validateDigits(value) {
            view.textColor = UIColor.red
        } else {
            view.textColor = UIColor.black
        }
    }
    
    private func getErrorMessage(_ value: String) -> String {
        if value.isEmpty {
            return AppStrings.errorCardNumber.value
        } else if isFormatCheck(value) || CardBrandType.getType(cardNumber).validateDigits(cardNumber) {
            return AppStrings.errorCardNumberFormat.value
        } else {
            // ブランクだと表示領域の高さだけ縮まるためダミーを返す
            return " "
        }
    }
    
    private func isFormatCheck(_ value: String) -> Bool {
        guard let regex = FincodeCardNoView.regex else { return true }
        return regex.matches(in: value, range: NSRange(location: 0, length: value.count)).count <= 0
    }
}
