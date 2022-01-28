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

