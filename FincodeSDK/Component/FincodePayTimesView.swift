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
    private var radioType: RadioType = .paymentBulk
    
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
    
    var payTimes: (method: String, payTimes: String?)? {
        get {
            switch(radioType) {
            case .paymentBulk:
                return ("1" , nil)
            case .paymentDivision:
                guard let value = textField.extText else { return nil }
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

extension FincodePayTimesView: RadioViewControllerDelegate {
    
    func didTouch(_ view: RadioView, radioType: RadioType) {
        self.radioType = radioType
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
