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
    @IBOutlet weak var holderNameView: FincodeHolderNameView!
    @IBOutlet weak var viewConstraints: NSLayoutConstraint!
    
    override func initialize(_ delegateList: [ComponentDelegate]? = nil) {
        super.initialize([cardNoView, expireView, securityCodeView, submitButtonView, holderNameView])
    }
    
    override func getInputInfo() -> InputInfo {
        return InputInfo(
            cardNumber: cardNoView.cardNumber,
            expireMonth: expireView.month,
            expireYear: expireView.year,
            securityCode: securityCodeView.cvc,
            holderName: holderNameView.holderName)
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