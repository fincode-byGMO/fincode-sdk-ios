//
//  FincodeVerticalView.swift
//  FincodeIos
//
//  Created by 中嶋彰 on 2021/12/26.
//

import UIKit

@IBDesignable
public class FincodeVerticalView: FincodeCommon {
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var cardNoView: FincodeCardNoView!
    @IBOutlet weak var expireView: FincodeExpireView!
    @IBOutlet weak var securityCodeView: FincodeSecurityCodeView!
    @IBOutlet weak var submitButtonView: FincodeSubmitButtonView!
    @IBOutlet weak var holderNameView: FincodeHolderNameView!
    @IBOutlet weak var payTimesView: FincodePayTimesView!
    @IBOutlet weak var viewConstraints: NSLayoutConstraint!
    
    private var selectCardAreaView: SelectCardAreaView?
  
    override func initialize(_ components :Components?) {
        super.initialize(Components(cardNoView: cardNoView, expireView: expireView, securityCodeView: securityCodeView,
                                    submitButtonView: submitButtonView, holderNameView: holderNameView, payTimesView: payTimesView))
    }
    
    override func getInputInfo() -> InputInfo {
        
        var cardId: String?
        var cardNumber = cardNoView.cardNumber
        if let view = selectCardAreaView, view.selectedRadio == .registeredCard {
            cardNumber = view.selectCardView.selectedCard?.cardNo ?? ""
            cardId = view.selectCardView.selectedCard?.id
        }
        
        return InputInfo(
            cardNumber: cardNumber,
            cardId: cardId,
            expireMonth: expireView.month,
            expireYear: expireView.year,
            securityCode: securityCodeView.cvc,
            holderName: holderNameView.holderName,
            payTimes: payTimesView.payTimes)
    }
    
    override func setCardList(_ list: [CardInfo]?) {
        if let li = list, 0 < li.count {
            viewConstraints.constant = 124
            selectCardAreaView = SelectCardAreaView()
            selectCardAreaView!.selectCardView.cardInfoList = li
            view.addSubview(selectCardAreaView!)
            selectCardAreaView!.anchorAll(equalTo: view)
        }
    }
}
