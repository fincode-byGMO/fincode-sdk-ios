//
//  FincodeHorizontalView.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/02/01.
//

import UIKit

@IBDesignable
public class FincodeHorizontalView: FincodeCommon {

    @IBOutlet weak var view: UIView!
    @IBOutlet weak var cardNoView: FincodeCardNoView!
    @IBOutlet weak var expireView: FincodeExpireView!
    @IBOutlet weak var securityCodeView: FincodeSecurityCodeView!
    @IBOutlet weak var submitButtonView: FincodeSubmitButtonView!
    @IBOutlet weak var viewConstraints: NSLayoutConstraint!
    
    override func initialize(_ delegateList: [ComponentDelegate]? = nil) {
        super.initialize([cardNoView, expireView, securityCodeView, submitButtonView])
    }
    
    override func getInputInfo() -> InputInfo {
        let cardNo = cardNoView.cardNumber
        let expireMonth = expireView.month
        let expireYear = expireView.year
        let securityCode = securityCodeView.cvc
        
        return InputInfo(cardNumber: cardNo, expireMonth: expireMonth, expireYear: expireYear, securityCode: securityCode)
    }
    
    override func setCardList(_ list: [CardInfo]?) {
        if let li = list, 0 < li.count {
            viewConstraints.constant = 124
            let selectCardAreaView = SelectCardAreaView()
            selectCardAreaView.cardInfoList = li
            view.addSubview(selectCardAreaView)
            selectCardAreaView.anchorAll(equalTo: view)
        }
    }
}
