//
//  FincodeSubmitButtonView.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/01/19.
//

import Foundation
import UIKit

@IBDesignable
class FincodeSubmitButtonView: UIView {
    
    @IBOutlet weak var submitButton: UIButton!
    
    var buttonType: SubmitButtonType = .none
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        viewSetup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        viewSetup()
    }
    
    fileprivate func initialize() {
        
        var title: String = ""
        switch(buttonType) {
        case .registerCard:
            title = "クレジットカードを登録"
        case .updateCard:
            title = "クレジットカードを更新"
        case .payment:
            title = "お支払い"
        default:
            break
        }
        submitButton.setTitle(title, for: .normal)
    }
    
    @IBAction func didTouchButton(_ sender: Any) {
        
        switch(buttonType) {
        case .registerCard:
            registerCard()
        case .updateCard:
            updateCard()
        case .payment:
            payment()
        default:
            break
        }
    }
    
    fileprivate func registerCard() {
        
    }
    
    fileprivate func updateCard() {
        
    }
    
    fileprivate func payment() {
        
    }
}
