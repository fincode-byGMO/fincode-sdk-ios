//
//  CustomPickerView.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/01/14.
//

import Foundation
import UIKit

final class CustomPickerView: UIControl {
    
    var picker: UIPickerView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        initialize()
    }
    
    private func initialize() {
        addTarget(self, action: #selector(viewTouch(_:)), for: .touchDown)
    }
    
    @objc func viewTouch(_ sender: CustomPickerView) {
        self.becomeFirstResponder()
    }
    
    override var inputView: UIView? {
        return picker
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override var inputAccessoryView: UIView? {
        return completedButton()
    }
    
    @objc private func tappedCloseButton(_ sender: UIButton) {
        resignFirstResponder()
    }
}
