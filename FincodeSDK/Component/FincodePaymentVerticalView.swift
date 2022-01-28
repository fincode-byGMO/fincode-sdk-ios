//
//  FincodePaymentVerticalView.swift
//  FincodeIos
//
//  Created by 中嶋彰 on 2021/12/26.
//

import UIKit

@IBDesignable
class FincodePaymentVerticalView: UIView {
    
    @IBOutlet weak var SelectCardArea: UIView!
    @IBOutlet weak var radioRegisteredCardView: RadioView!
    @IBOutlet weak var radioNewCardView: RadioView!
    @IBOutlet weak var selectCardView: FincodeSelectCardView!
    
    @IBOutlet weak var cardNoView: FincodeCardNoView!
    @IBOutlet weak var expireView: FincodeExpireView!
    @IBOutlet weak var securityCodeView: FincodeSecurityCodeView!
    
    private var radioViewController: RadioViewController?
    
    private var presenter: PaymentPresenter!

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
        self.presenter = PaymentPresenter(view: nil, interactor: PaymentInteractor())
        
        radioViewController = RadioViewController(radioRegisteredCardView, radioNewCardView)
        
        // DEBUG用 削除予定
        let cardInfoList = [CardInfo("5555 7777 8888 6666", "09/23"), CardInfo("3333 5555 6666 8888", "10/24")]
        
        selectCardView.setData(cardInfoList)
    }
    
    /// 設定情報
    /// - Parameter config:
    public func setConfiguration(_ config :FincodeConfiguration) {
        self.presenter.config = config
    }
    

    
//    @IBAction func touchPaymentButton(_ sender: Any) {
//        self.presenter.didTapPayment()
//    }
    
}
