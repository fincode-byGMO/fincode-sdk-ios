//
//  FincodeCardNoView.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/01/11.
//

import Foundation
import UIKit

@IBDesignable
class FincodeCardNoView: UIView {
    
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var cardNumberTextView: CustomTextField!
    @IBOutlet weak var selectCardImage: UIImageView!
    @IBOutlet weak var errorLabelView: UILabel!
    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var cardImageView: UIView!
    
    
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
        cardNumberTextView.closable()
        isHeadingHidden(false)
    }
    
    private func isHeadingHidden(_ status: Bool) {
        headingLabel.isHidden = status
        // selectCardImage.isHidden = status
        // cardImageView.isHidden = status
    }
}

extension FincodeCardNoView: ValidateDelegate {
    
    func validate() -> Bool {
        let err = cardNumberTextView.text?.isEmpty ?? false
        borderView.isBorderError(err)
        cardNumberTextView.isPlaceholderError(err)
        errorLabelView.isHidden = !err
        
        return err
    }
}
