//
//  FincodePaymentVerticalView.swift
//  FincodeIos
//
//  Created by 中嶋彰 on 2021/12/26.
//

import UIKit

@IBDesignable
class FincodePaymentVerticalView: UIView {
    
    @IBOutlet weak var selectCardArea: UIView!
    @IBOutlet weak var radioRegisteredCardView: RadioView!
    @IBOutlet weak var radioNewCardView: RadioView!
    @IBOutlet weak var selectCardView: FincodeSelectCardView!
    
    @IBOutlet weak var cardNoView: FincodeCardNoView!
    @IBOutlet weak var expireView: FincodeExpireView!
    @IBOutlet weak var securityCodeView: FincodeSecurityCodeView!
    @IBOutlet weak var submitButtonView: FincodeSubmitButtonView!
    
    private var presenter: PaymentPresenter!
    
    private var radioViewController: RadioViewController?
    private var validateDelegateList: [ValidateDelegate] = []
    private var config :FincodeConfiguration = FincodeConfiguration()
    
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
        
        validateDelegateList.append(contentsOf: [cardNoView, expireView, securityCodeView])
        radioViewController = RadioViewController(radioRegisteredCardView, radioNewCardView)
        submitButtonView.delegate = self
        
        
        submitButtonView.useCase = config.useCase
        
        // DEBUG用 削除予定
        let cardInfoList = [CardInfo("5555 7777 8888 6666", "09/23"), CardInfo("3333 5555 6666 8888", "10/24")]
        selectCardView.setData(cardInfoList)
    }
    
    /// 設定情報
    /// - Parameter config:
    public func setConfiguration(_ config :FincodeConfiguration) {
        self.config = config
    }
    


}

extension FincodePaymentVerticalView: FincodeSubmitButtonViewDelegate {

    func fincodeSubmitButtonView() -> PaymentPresenter? {
        guard validate() else { return nil }
        return presenter
    }
    
    private func validate() -> Bool {
        var isError = false
        for item in validateDelegateList {
            let result = item.validate()
            isError = isError || result
        }
        return isError
    }
}
