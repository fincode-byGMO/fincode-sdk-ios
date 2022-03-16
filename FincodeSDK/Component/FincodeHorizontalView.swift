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
    @IBOutlet weak var payTimesView: FincodePayTimesView!
    @IBOutlet weak var viewConstraints: NSLayoutConstraint!
    
    private var selectCardAreaView: SelectCardAreaView?
    
    override func initialize(_ components :Components?) {
        super.initialize(Components(cardNoView: cardNoView, expireView: expireView, securityCodeView: securityCodeView,
                                    submitButtonView: submitButtonView, holderNameView: holderNameView, payTimesView: payTimesView,
                                    selectCardAreaView: SelectCardAreaView(), selectCardAreaBaseView: view, selectCardAreaConstraints: viewConstraints))
    }
    
    override func getInputInfo() -> InputInfo {
        
        var useCard: UseCard = .newCard
        var cardId: String?
        var cardNumber: String? = cardNoView.cardNumber
        if let view = selectCardAreaView, view.selected == .registeredCard {
            useCard = .registeredCard
            cardId = view.selectCardView.selectedCard?.id
            cardNumber = nil
        }
        
        return InputInfo(
            useCard: useCard,
            cardNumber: cardNumber,
            cardId: cardId,
            expireMonth: expireView.month,
            expireYear: expireView.year,
            securityCode: securityCodeView.cvc,
            holderName: holderNameView.holderName,
            payTimes: payTimesView.payTimes
        )
    }
}
