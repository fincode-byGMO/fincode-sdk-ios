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
}

extension FincodeSecurityCodeView: CustomTextFieldDelegate {
    func textChanged(_ view: CustomTextField) {
        // do nothing
    }
    
    func valideteTextEndEditing(_ view: CustomTextField) -> Bool {
        let isError = cvcTextView.text?.isEmpty ?? false
        errorLabelView.text = AppStrings.errorSecurityCode.value
        errorLabelView.isHidden = !isError
        
        imageView.image = isError ?
                UIImage(named: "cvc_error_ic", in: BundleUtil.instance.bundle, compatibleWith: nil) :
                UIImage(named: "cvc_ic", in: BundleUtil.instance.bundle, compatibleWith: nil)
        
        return isError
    }
}
