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
    
    @IBOutlet weak var cvcTextView: CustomTextField!
    @IBOutlet weak var errorLabelView: UILabel!
    
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
    }
}

extension FincodeSecurityCodeView: ValidateDelegate {
    
    func validate() -> Bool {
        
        let err = cvcTextView.text?.isEmpty ?? false
        cvcTextView.isBorderError(err)
        cvcTextView.isPlaceholderError(err)
        errorLabelView.isHidden = !err
        
        return false
    }
}
