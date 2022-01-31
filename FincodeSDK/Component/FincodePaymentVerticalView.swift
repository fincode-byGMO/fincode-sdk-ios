//
//  FincodePaymentVerticalView.swift
//  FincodeIos
//
//  Created by 中嶋彰 on 2021/12/26.
//

import UIKit

@IBDesignable
class FincodePaymentVerticalView: UIView {
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var cardNoView: FincodeCardNoView!
    @IBOutlet weak var expireView: FincodeExpireView!
    @IBOutlet weak var securityCodeView: FincodeSecurityCodeView!
    @IBOutlet weak var submitButtonView: FincodeSubmitButtonView!
    
    @IBOutlet weak var viewConstraints: NSLayoutConstraint!

    private var presenter: PaymentPresenter!
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
        submitButtonView.delegate = self
        submitButtonView.useCase = config.useCase
        
        // TODO 分岐を実装する
        if true {
            addSelectCardArea()
        } else {
            viewConstraints.constant = 0
        }
        
    }
    
    fileprivate func addSelectCardArea() {
        let selectCardAreaView = SelectCardAreaView()
        view.addSubview(selectCardAreaView)
        selectCardAreaView.anchorAll(equalTo: view)
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
    
    fileprivate func validate() -> Bool {
        var isError = false
        for item in validateDelegateList {
            let result = item.validate()
            isError = isError || result
        }
        return isError
    }
}
