//
//  RadioView.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/01/20.
//

import Foundation
import UIKit

protocol RadioViewDelegate: AnyObject {
    func radioView(_ view: RadioView, radioType: RadioType)
}

@IBDesignable
class RadioView: UIControl {
    
    @IBOutlet weak var labelView: UILabel!
    @IBOutlet weak var insideCircle: UIView!
    @IBOutlet weak var button: UIButton!
    
    fileprivate var rtype: RadioType = .none
    fileprivate var checked: Bool = false
    var delegate: RadioViewDelegate?
    
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
        
        button.setTitle("", for: .normal)
    }
    
    /// RadioTypeの値のみを設定してください。
    /// ・登録済みのカードの場合: registeredCard
    /// ・新しいクレジットカードの場合: newCard
    /// ・決済（一括）の場合: titlePaymentBulkRadio
    /// ・決済（分割）の場合: titlePaymentDivisionRadio
    @IBInspectable public var radioType: String {
        get {
            return self.rtype.rawValue
        }
        set {
            self.rtype = RadioType(rawValue: newValue) ?? .none
            labelView.text = self.rtype.title
        }
    }
    
    @IBInspectable public var isChecked: Bool {
        get {
            return self.checked
        }
        set {
            checkedBackgroundColor(newValue)
            self.checked = newValue
        }
    }
    
    fileprivate func checkedBackgroundColor(_ isChecked: Bool) {
        
        insideCircle.extBackgroundColor = isChecked ? ColorController.instance.color(.primary) : ColorController.instance.color(.radioCheckedOff)
    }
    
    @IBAction func didTouch(_ sender: Any) {
        guard let dg = delegate else { return }
        dg.radioView(self, radioType: rtype)
    }
}
