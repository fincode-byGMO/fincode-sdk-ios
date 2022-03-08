//
//  FincodeCommon.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/02/03.
//

import Foundation
import UIKit

@IBDesignable
public class FincodeCommon: UIView, PaymentPresenterNotify, CardRegisterPresenterNotify, CardUpdatePresenterNotify {
    
    struct Components {
        var cardNoView: FincodeCardNoView
        var expireView: FincodeExpireView
        var securityCodeView: FincodeSecurityCodeView
        var submitButtonView: FincodeSubmitButtonView
        var holderNameView: FincodeHolderNameView
        var payTimesView: FincodePayTimesView
        
        init(cardNoView: FincodeCardNoView, expireView: FincodeExpireView, securityCodeView: FincodeSecurityCodeView,
             submitButtonView: FincodeSubmitButtonView, holderNameView: FincodeHolderNameView, payTimesView: FincodePayTimesView) {
            self.cardNoView = cardNoView
            self.expireView = expireView
            self.securityCodeView = securityCodeView
            self.submitButtonView = submitButtonView
            self.holderNameView = holderNameView
            self.payTimesView = payTimesView
        }
        
        func componetList() -> [ComponentDelegate] {
            return [cardNoView, expireView, securityCodeView, submitButtonView, holderNameView, payTimesView]
        }
    }
    
    private var mHeadingHidden: Bool = false
    private var mDynamicLogDisplay: Bool = false
    private var mHolderNameHidden: Bool = false
    private var mMethodHidden: Bool = false
    private var components: Components?
    private var externalResultDelegate :ResultDelegate?
    var paymentPresenter: PaymentPresenterDelegate?
    var cardOperatePresenter: CardRegisterPresenterDelegate?
    var cardUpdatePresenter: CardUpdatePresenterDelegate?
    
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
    
    func initialize(_ componets: Components? = nil) {
        self.components = componets
        self.components?.submitButtonView.delegate = self
    }
    
    func getInputInfo() -> InputInfo {
        // 派生先で実装
        return InputInfo()
    }
    
    private func initComponent() {
        guard let config = DataHolder.instance.config, let button = components?.submitButtonView else { return }
        
        button.buttonTitle(config.useCase.title)
        switch config.useCase {
        case .registerCard:
            cardOperatePresenter = CardRegisterPresenter(interactor: CardOperateInteractor())
        case .updateCard:
            cardUpdatePresenter = CardUpdatePresenter(interactor: CardOperateInteractor())
        case .payment:
            paymentPresenter = PaymentPresenter(interactor: PaymentInteractor(), interactorCard: CardOperateInteractor())
            paymentPresenter?.viewNotify = self
            paymentPresenter?.cardInfoList(config)
        default:
            break
        }
    }
    
    /// 見出しの表示・非表示を設定します
    ///
    /// true: 表示
    ///
    /// false: 非表示
    @IBInspectable public var headingHidden: Bool {
        get {
            return mHeadingHidden
        }
        set {
            mHeadingHidden = newValue
            guard let comp = components else { return }
            for item in comp.componetList() {
                item.headingHidden = !newValue
            }
        }
    }
    
    /// ブランド画像 動的切り替えの表示・非表示を設定します
    ///
    /// true: 表示
    ///
    /// false: 非表示
    @IBInspectable public var dynamicLogDisplay: Bool {
        get {
            return mDynamicLogDisplay
        }
        set {
            mDynamicLogDisplay = newValue
            guard let view: FincodeCardNoView = components?.cardNoView else { return }
            view.dynamicLogDisplay = !newValue
        }
    }
    
    /// 名義人名の表示・非表示を設定します
    ///
    /// true: 表示
    ///
    /// false: 非表示
    @IBInspectable public var holderNameHidden: Bool {
        get {
            return mHolderNameHidden
        }
        set {
            mHolderNameHidden = newValue
            guard !newValue, let view: FincodeHolderNameView = components?.holderNameView else { return }
            view.setViewGoneVertical()
        }
    }
    
    /// お支払い回数の表示・非表示を設定します
    ///
    /// true: 表示
    ///
    /// false: 非表示
    @IBInspectable public var methodHidden: Bool {
        get {
            return mMethodHidden
        }
        set {
            mMethodHidden = newValue
            guard !newValue, let view: FincodePayTimesView = components?.payTimesView else { return }
            view.setViewGoneVertical()
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
            return externalResultDelegate
        }
        set {
            externalResultDelegate = newValue
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
    
    // 決済実行 成功
    func paymentSuccess(_ result: FincodeResult) {
        externalResultDelegate?.success(result)
    }
    
    // 決済実行 失敗
    func paymentFailure() {
        externalResultDelegate?.failure()
    }
    
    // カード登録 成功
    func cardRegisterSuccess(_ result: FincodeResult) {
        externalResultDelegate?.success(result)
    }
    
    // カード登録 失敗
    func cardRegisterFailure() {
        externalResultDelegate?.failure()
    }
    
    // カード更新 成功
    func cardUpdateSuccess(_ result: FincodeResult) {
        externalResultDelegate?.success(result)
    }
    
    // カード更新 失敗
    func cardUpdateFailure() {
        externalResultDelegate?.failure()
    }
    
    // カード一覧取得 成功
    func cardListSuccess(_ list: [CardInfo]?) {
        // 派生先で実装
    }
    
    // カード一覧取得 失敗
    func cardListFailure() {
        // do nothing
    }
}

extension FincodeCommon: FincodeSubmitButtonViewDelegate {

    func fincodeSubmitButtonView() -> BasePresenterDelegate? {
        DataHolder.instance.inputInfo = getInputInfo()
        guard !validate(), let config = DataHolder.instance.config else { return nil }

        switch config.useCase {
        case .registerCard:
            cardOperatePresenter?.viewNotify = self
            return cardOperatePresenter
        case .updateCard:
            cardUpdatePresenter?.viewNotify = self
            return cardUpdatePresenter
        case .payment:
            paymentPresenter?.viewNotify = self
            return paymentPresenter
        default:
            return nil
        }
    }
    
    fileprivate func validate() -> Bool {
        guard let comp = components else { return false }
        var isError = false
        for item in comp.componetList() {
            let result = item.validate()
            isError = isError || result
        }
        return isError
    }
}
