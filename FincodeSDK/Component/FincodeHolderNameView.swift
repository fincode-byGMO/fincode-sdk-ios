//
//  FincodeHolderNameView.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/01/14.
//

import Foundation
import UIKit

@IBDesignable
class FincodeHolderNameView: UIView {
    
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var holderTextView: CustomTextField!
    @IBOutlet weak var errorLabelView: UILabel!
    @IBOutlet weak var borderView: UIView!
    
    static private let regex: NSRegularExpression? = try? NSRegularExpression(pattern: "^[a-zA-Z0-9 ¥¥x2c-¥¥x2f]{0,50}$")
    
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
        holderTextView.closable()
        holderTextView.customTextFieldDelegate = self
        holderTextView.borderView = borderView
    }
    
    var holderName: String {
        get {
            return holderTextView.text ?? ""
        }
    }
}

extension FincodeHolderNameView: ComponentDelegate {
    
    var headingHidden: Bool {
        get {
            return headingLabel.isHidden
        }
        set {
            headingLabel.isHidden = newValue
        }
    }
    
    func validate() -> Bool {
        return holderTextView.validete()
    }
    
    func clear() {
        errorLabelView.isHidden = true
        holderTextView.endEditingBorder(false)
        holderTextView.isPlaceholderError(false)
    }
}

extension FincodeHolderNameView: CustomTextFieldDelegate {
    func textChanged(_ view: CustomTextField) {
        // do nothing
    }
    
    func valideteTextEndEditing(_ view: CustomTextField) -> Bool {
        guard let value = holderTextView.text, let regex = FincodeHolderNameView.regex else { return false }

        if regex.matches(in: value, range: NSRange(location: 0, length: value.count)).count <= 0 {
            errorLabelView.text = AppStrings.errorHolderName.value
            errorLabelView.isHidden = false
            return true
        } else {
            errorLabelView.isHidden = true
            return false
        }
    }
}
