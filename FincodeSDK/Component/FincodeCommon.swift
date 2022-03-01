//
//  FincodeCommon.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/02/03.
//

import Foundation
import UIKit

@IBDesignable
public class FincodeCommon: UIView {   
    
    private var mHeadingHidden: Bool = false
    private var componentDelegateList: [ComponentDelegate] = []
    private var externalResultDelegate :ResultDelegate?
    var paymentPresenter: PaymentPresenterDelegate?
    var cardOperatePresenter: CardOperatePresenterDelegate?
    
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
    
    func initialize(_ delegateList: [ComponentDelegate]? = nil) {
        componentDelegateList = delegateList ?? []
        if let button = getSubmitButtonView() {
            button.delegate = self
        }
    }
    
    func setCardList(_ list: [CardInfo]?) {
        // 派生先で実装
    }
    
    func getInputInfo() -> InputInfo {
        // 派生先で実装
        return InputInfo()
    }
    
    private func getSubmitButtonView() -> FincodeSubmitButtonView? {
        if let button = componentDelegateList.filter({ type(of: $0) ==  FincodeSubmitButtonView.self}).first as? FincodeSubmitButtonView {
            return button
        } else {
            return nil
        }
    }
    
    private func setHeadingHidden() {
        for item in componentDelegateList {
            item.headingHidden = mHeadingHidden
        }
    }
    
    private func initComponent() {
        guard let config = DataHolder.instance.config, let button = getSubmitButtonView() else { return }
        
        button.buttonTitle(config.useCase.title)
        switch config.useCase {
        case .registerCard:
            cardOperatePresenter = CardOperatePresenter(interactor: CardOperateInteractor(), uiview: self)
        case .updateCard:
            cardOperatePresenter = CardOperatePresenter(interactor: CardOperateInteractor(), uiview: self)
        case .payment:
            paymentPresenter = PaymentPresenter(interactor: PaymentInteractor(), uiview: self)
            cardOperatePresenter = CardOperatePresenter(interactor: CardOperateInteractor(), uiview: self)
            cardOperatePresenter?.cardInfoList(config)
        default:
            break
        }
    }
    
    @IBInspectable public var headingHidden: Bool {
        get {
            return mHeadingHidden
        }
        set {
            mHeadingHidden = newValue
            setHeadingHidden()
        }
    }
    
    /// 処理結果を返します
    ///
    /// 処理に対応したクラスを使用してください
    ///
    /// - 決済: FincodePaymentRequest
    ///
    /// - カード登録: FincodeCardRegisterRequest
    ///
    /// - カード更新: FincodeCardUpdateResponse
    public var resultDelegate: ResultDelegate? {
        get {
            return paymentPresenter?.externalResultDelegate
        }
        set {
            paymentPresenter?.externalResultDelegate = newValue
        }
    }
    
    /// 処理に必要な情報を設定します
    ///
    /// 処理に対応したクラスを使用してください
    ///
    /// - 決済: FincodePaymentConfiguration
    ///
    /// - カード登録: FincodeCardRegisterConfiguration
    ///
    /// - カード更新: FincodeCardUpdateConfiguration
    public func configuration(_ config: FincodeConfiguration?) {
        DataHolder.instance.config = config
        initComponent()
    }
}

extension FincodeCommon: FincodeSubmitButtonViewDelegate {

    func fincodeSubmitButtonView() -> PaymentPresenterDelegate? {
        guard !validate(), let presenter = paymentPresenter else { return nil }
        DataHolder.instance.inputInfo = getInputInfo()
        presenter.externalResultDelegate = externalResultDelegate
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
