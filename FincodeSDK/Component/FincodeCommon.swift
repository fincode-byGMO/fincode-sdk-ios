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
    private var config :FincodeConfiguration = FincodeConfiguration()
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
        paymentPresenter = PaymentPresenter(config, interactor: PaymentInteractor(), uiview: self)
        cardOperatePresenter = CardOperatePresenter(config, interactor: CardOperateInteractor(), uiview: self)
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
    public var resultDelegate: ResultDelegate? {
        get {
            return paymentPresenter?.externalResultDelegate
        }
        set {
            paymentPresenter?.externalResultDelegate = newValue
        }
    }
    
    /// 処理に必要な情報を設定します
    public var configuration: FincodeConfiguration {
        get {
            return config
        }
        set {
            config = newValue
            if let button = getSubmitButtonView() {
                button.config = config
            }
            cardOperatePresenter?.cardInfoList(newValue)
        }
    }
    
//    /// 設定情報
//    /// - Parameter config:設定値
//    /// - Parameter resultDelegate:処理結果
//    public func setConfiguration(_ config :FincodeConfiguration, resultDelegate: ResultDelegate? = nil) {
//        self.externalResultDelegate = resultDelegate
//        self.config = config
//        if let button = getSubmitButtonView() {
//            button.config = config
//        }
//    }
}

extension FincodeCommon: FincodeSubmitButtonViewDelegate {

    func fincodeSubmitButtonView() -> PaymentPresenterDelegate? {
        guard !validate(), let presenter = paymentPresenter else { return nil }
        presenter.inputInfo = getInputInfo()
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
