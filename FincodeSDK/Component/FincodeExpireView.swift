//
//  FincodeExpireView.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/01/12.
//

import Foundation
import UIKit

@IBDesignable
class FincodeExpireView: UIView {
    
    @IBOutlet weak var monthTextView: UITextField!
    @IBOutlet weak var errorMonthLabelView: UILabel!
    @IBOutlet weak var yearTextView: UITextField!
    @IBOutlet weak var errorYearLabelView: UILabel!
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        viewSetup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        viewSetup()
    }
}

extension FincodeExpireView: ValidateDelegate {
    
    func validate() -> Bool {
        
        let monthErr = monthTextView.text?.isEmpty ?? false
        monthTextView.isBorderError(monthErr)
        monthTextView.isPlaceholderError(monthErr)
        errorMonthLabelView.isHidden = !monthErr
        
        let yearErr = yearTextView.text?.isEmpty ?? false
        yearTextView.isBorderError(yearErr)
        yearTextView.isPlaceholderError(yearErr)
        errorYearLabelView.isHidden = !yearErr
        
        return monthErr || yearErr
    }
}
