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
    
    @IBOutlet weak var cardNumberTextView: UITextField!
    @IBOutlet weak var selectCardImage: UIImageView!
    @IBOutlet weak var errorLabelView: UILabel!
    @IBOutlet weak var borderView: UIView!
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        viewSetup()
        initialize()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        viewSetup()
    }
    
    fileprivate func initialize() {
        
    }
}

extension FincodeCardNoView: UITextFieldDelegate {
    
    // フォーカス外れた後
    func textFieldDidEndEditing(_ textField: UITextField) {
     
//        cardNumberTextView.endEditing(true)
    }
    
    // キーボードのreturnタップ後
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        cardNumberTextView.endEditing(true)
        return true
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
