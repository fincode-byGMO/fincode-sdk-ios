//
//  FincodeSecurityCodeView.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/01/12.
//

import Foundation
import UIKit

@IBDesignable
class FincodeSecurityCodeView: UIView {
    
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var cvcTextView: CustomTextField!
    @IBOutlet weak var errorLabelView: UILabel!
    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    static private let regex: NSRegularExpression? = try? NSRegularExpression(pattern: "^[0-9]{3,4}$")
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
        cvcTextView.closable()
        cvcTextView.customTextFieldDelegate = self
        cvcTextView.borderView = borderView
    }
    
    var cvc: String {
        get {
            return cvcTextView.text ?? ""
        }
    }
}

extension FincodeSecurityCodeView: ComponentDelegate {
    
    var headingHidden: Bool {
        get {
            return headingLabel.isHidden
        }
        set {
            headingLabel.isHidden = newValue
        }
    }
    
    func validate() -> Bool {
        return cvcTextView.validete()
    }
    
    func clear() {
        errorLabelView.isHidden = true
        cvcTextView.endEditingBorder(false)
        cvcTextView.isPlaceholderError(false)
        imageView.image = UIImage(named: "cvc_ic", in: BundleUtil.instance.bundle, compatibleWith: nil)
    }
    
    func enabled(_ isEnabled: Bool) {
        cvcTextView.isEnabled = isEnabled
    }
}

extension FincodeSecurityCodeView: CustomTextFieldDelegate {
    func textChanged(_ view: CustomTextField) {
        // do nothing
    }
    
    func valideteTextEndEditing(_ view: CustomTextField) -> Bool {
        guard let value = cvcTextView.text, let regex = FincodeSecurityCodeView.regex else { return false }

        var isError = false
        if !value.isEmpty, regex.matches(in: value, range: NSRange(location: 0, length: value.count)).count <= 0 {
            isError = true
        }
        
        errorLabelView.text = AppStrings.errorSecurityCode.value
        errorLabelView.isHidden = !isError
        
        imageView.image = isError ?
                UIImage(named: "cvc_error_ic", in: BundleUtil.instance.bundle, compatibleWith: nil) :
                UIImage(named: "cvc_ic", in: BundleUtil.instance.bundle, compatibleWith: nil)
        
        return isError
    }
}
