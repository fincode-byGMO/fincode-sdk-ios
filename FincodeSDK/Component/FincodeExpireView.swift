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
    
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var monthTextView: CustomTextField!
    @IBOutlet weak var errorMonthLabelView: UILabel!
    @IBOutlet weak var yearTextView: CustomTextField!
    @IBOutlet weak var errorYearLabelView: UILabel!
    
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
        monthTextView.closable()
        yearTextView.closable()
        isHeadingHidden(false)
    }
    
    private func isHeadingHidden(_ status: Bool) {
        headingLabel.isHidden = status
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
