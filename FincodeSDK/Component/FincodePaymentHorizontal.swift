//
//  FincodePaymentHorizontal.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/02/01.
//

import UIKit

@IBDesignable
class FincodePaymentHorizontal: UIView {

    @IBOutlet weak var view: UIView!
    @IBOutlet weak var cardNoView: FincodeCardNoView!
    @IBOutlet weak var expireView: FincodeExpireView!
    @IBOutlet weak var securityCodeView: FincodeSecurityCodeView!
    @IBOutlet weak var submitButtonView: FincodeSubmitButtonView!
    
    @IBOutlet weak var viewConstraints: NSLayoutConstraint!
    
    private var presenter: PaymentPresenter!
    private var componentDelegateList: [ComponentDelegate] = []
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
        
        componentDelegateList.append(contentsOf: [cardNoView, expireView, securityCodeView, submitButtonView])
        submitButtonView.delegate = self
        
        submitButtonView.useCase = config.useCase
//        for item in componentDelegateList {
//            item.headingHidden(config.) // TODO 設定情報を反映する
//        }
        
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

extension FincodePaymentHorizontal: FincodeSubmitButtonViewDelegate {

    func fincodeSubmitButtonView() -> PaymentPresenter? {
        guard validate() else { return nil }
        return presenter
    }
    
    fileprivate func validate() -> Bool {
        var isError = false
        for item in componentDelegateList {
            let result = item.validate()
            isError = isError || result
        }
        return isError
    }
}
