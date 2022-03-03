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
    @IBOutlet weak var bulkView: RadioView!
    @IBOutlet weak var divisionView: RadioView!
    @IBOutlet weak var textFieldConstraint: NSLayoutConstraint!
    
    private var radioViewController: RadioViewController?
    
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
        textField.isHidden = true
        radioViewController = RadioViewController(bulkView, divisionView)
        radioViewController?.delegate = self
    }
    
    var payTimes: String {
        get {
            guard let value = textField.extText else { return "" }
            return String(value)
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
}

extension FincodePayTimesView: RadioViewControllerDelegate {
    
    func didTouch(_ view: RadioView, radioType: RadioType) {
        switch(radioType) {
        case .paymentDivision:
            textField.isHidden = false
            textField.selectRow(0)
        default:
            textField.isHidden = true
            textField.endEditing(true)
        }
    }
}

//extension FincodeMethodView: CustomTextFieldDelegate {
//    func textChanged(_ view: CustomTextField) {
//        // do nothing
//    }
//
//    func valideteTextEndEditing(_ view: CustomTextField) -> Bool {
//        let isError = cvcTextView.text?.isEmpty ?? false
//        errorLabelView.text = AppStrings.errorSecurityCode.value
//        errorLabelView.isHidden = !isError
//
//        imageView.image = isError ?
//                UIImage(named: "cvc_error_ic", in: BundleUtil.instance.bundle, compatibleWith: nil) :
//                UIImage(named: "cvc_ic", in: BundleUtil.instance.bundle, compatibleWith: nil)
//
//        return isError
//    }
//}
