//
//  FincodeCommon.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/02/03.
//

import Foundation
import UIKit

protocol FincodeCommonDelegate: AnyObject {
    func setCardList(_ list: [FincodeCardInfo]?)
    func showIndicator()
    func hideIndicator()
}

@IBDesignable
public class FincodeCommon: UIView, FincodeCommonDelegate {
    
    struct Components {
        var cardNoView: FincodeCardNoView
        var expireView: FincodeExpireView
        var securityCodeView: FincodeSecurityCodeView
        var submitButtonView: FincodeSubmitButtonView
        var holderNameView: FincodeHolderNameView
        var payTimesView: FincodePayTimesView
        var selectCardAreaView: SelectCardAreaView
        var selectCardAreaBaseView: UIView
        var selectCardAreaConstraints: NSLayoutConstraint
        var indicatorView: UIView
        var indicator: UIActivityIndicatorView
        
        init(cardNoView: FincodeCardNoView, expireView: FincodeExpireView, securityCodeView: FincodeSecurityCodeView,
             submitButtonView: FincodeSubmitButtonView, holderNameView: FincodeHolderNameView, payTimesView: FincodePayTimesView,
             selectCardAreaView: SelectCardAreaView, selectCardAreaBaseView: UIView, indicatorView: UIView, indicator: UIActivityIndicatorView,
             selectCardAreaConstraints: NSLayoutConstraint) {
            self.cardNoView = cardNoView
            self.expireView = expireView
            self.securityCodeView = securityCodeView
            self.submitButtonView = submitButtonView
            self.holderNameView = holderNameView
            self.payTimesView = payTimesView
            self.selectCardAreaView = selectCardAreaView
            self.selectCardAreaBaseView = selectCardAreaBaseView
            self.selectCardAreaConstraints = selectCardAreaConstraints
            self.indicatorView = indicatorView
            self.indicator = indicator
        }
        
        func allComp() -> [ComponentDelegate] {
            return [cardNoView, expireView, securityCodeView, holderNameView, payTimesView]
        }
        
        func enabledComp() -> [ComponentDelegate] {
            return [cardNoView, expireView, securityCodeView, holderNameView]
        }
    }
    
    private var mHeadingHidden: Bool = false
    private var mDynamicLogDisplay: Bool = false
    private var mHolderNameHidden: Bool = false
    private var mPayTimesHidden: Bool = false
    private var components: Components?
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
        if #available(iOS 13.0, *) {
            self.components?.indicator.activityIndicatorViewStyle = .large
        } else {
            self.components?.indicator.activityIndicatorViewStyle = .gray
        }
    }
    
    func getInputInfo() -> InputInfo? {
        guard let comp = components else { return nil }
        
        var inputInfo: InputInfo?
        if comp.selectCardAreaView.selected == .registeredCard {
            inputInfo = InputInfo(
                useCard: .registeredCard,
                cardNumber: nil,
                cardId: comp.selectCardAreaView.selectCardView.selectedCard?.id,
                expireMonth: nil,
                expireYear: nil,
                securityCode: nil,
                holderName: nil,
                payTimes: comp.payTimesView.payTimes
            )
        } else {
            inputInfo = InputInfo(
                useCard: .newCard,
                cardNumber: comp.cardNoView.cardNumber,
                cardId: nil,
                expireMonth: comp.expireView.month,
                expireYear: comp.expireView.year,
                securityCode: comp.securityCodeView.cvc,
                holderName: comp.holderNameView.holderName,
                payTimes: comp.payTimesView.payTimes
            )
        }
        
        return inputInfo
    }
    
    private func gonePayTimesView() {
        if let comp = components {
            if type(of: self) == FincodeVerticalView.self {
                comp.payTimesView.setViewGoneVertical()
            } else {
                comp.payTimesView.setViewGoneHorizontal()
                
            }
        }
    }
    
    private func goneHolderNameView() {
        if let comp = components {
            if type(of: self) == FincodeVerticalView.self {
                comp.holderNameView.setViewGoneVertical()
            } else {
                comp.holderNameView.setViewGoneHorizontal()
            }
        }
    }
    
    private func goneCardNoView() {
        if let comp = components {
            if type(of: self) == FincodeVerticalView.self {
                comp.cardNoView.setViewGoneVertical()
            } else {
                comp.cardNoView.setViewGoneHorizontal()
            }
        }
    }
    
    private func initComponent(_ delegate: ResultDelegate) {
        guard let config = DataHolder.instance.config,
              let button = components?.submitButtonView,
              let parentViewController = parentViewController else { return }
        
        activeNewCard()
        button.buttonTitle(config.useCase.title)
        switch config.useCase {
        case .registerCard:
            gonePayTimesView()
            cardOperatePresenter = CardRegisterPresenter(interactor: CardOperateInteractor(), view: self)
            cardOperatePresenter?.externalResultDelegate = delegate
        case .updateCard:
            gonePayTimesView()
            goneCardNoView()
            cardUpdatePresenter = CardUpdatePresenter(interactor: CardOperateInteractor(), view: self)
            cardUpdatePresenter?.externalResultDelegate = delegate
        case .payment:
            paymentPresenter = PaymentPresenter(interactor: PaymentInteractor(), interactorCard: CardOperateInteractor(), router: PaymentRouter(parentViewController), view: self)
            paymentPresenter?.externalResultDelegate = delegate
            if !config.customerId.isEmpty {
                paymentPresenter?.cardInfoList(config)
            }
        default:
            break
        }
    }
    
    private func componentEnabled(_ isEnabled: Bool) {
        guard let comp = components else { return }
        for item in comp.enabledComp() {
            item.enabled(isEnabled)
        }
    }
    
    private func componentClear() {
        guard let comp = components else { return }
        for item in comp.allComp() {
            item.clear()
        }
    }
    
    private func activeRegisteredCard() {
        guard let comp = components else { return }
        componentEnabled(false)
        comp.selectCardAreaView.selectCardView.enabled(true)
    }
    
    private func activeNewCard() {
        guard let comp = components else { return }
        componentEnabled(true)
        comp.selectCardAreaView.selectCardView.enabled(false)
    }
    
    func showIndicator() {
        guard let comp = components else { return }
        comp.indicatorView.isHidden = false
        comp.indicator.startAnimating()
    }
    
    func hideIndicator() {
        guard let comp = components else { return }
        comp.indicatorView.isHidden = true
        comp.indicator.stopAnimating()
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
            for item in comp.allComp() {
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
            if !newValue {
                goneHolderNameView()
            }
        }
    }
    
    /// お支払い回数の表示・非表示を設定します
    ///
    /// true: 表示
    ///
    /// false: 非表示
    @IBInspectable public var payTimesHidden: Bool {
        get {
            return mPayTimesHidden
        }
        set {
            mPayTimesHidden = newValue
            if !newValue {
                gonePayTimesView()
            }
        }
    }
    
    /// 処理に必要な情報を設定します
    ///
    /// 処理に対応したクラスを使用してください
    ///
    /// - Parameters:
    ///   - config: 設定情報
    ///     - 決済: FincodePaymentConfiguration
    ///
    ///     - カード登録: FincodeCardRegisterConfiguration
    ///
    ///     - カード更新: FincodeCardUpdateConfiguration
    ///
    ///   - delegate: 処理結果
    ///     - 決済: FincodePaymentRequest
    ///
    ///     - カード登録: FincodeCardRegisterRequest
    ///
    ///     - カード更新: FincodeCardUpdateResponse
    public func configuration(_ config: FincodeConfiguration?, delegate: ResultDelegate) {
        DataHolder.instance.config = config
        initComponent(delegate)
    }
    
    func setCardList(_ list: [FincodeCardInfo]?) {
        guard let comp = components, let li = list else { return }
        
        if 0 < li.count {
            activeRegisteredCard()
            comp.selectCardAreaView.selected = .registeredCard
            
            let baseView = comp.selectCardAreaBaseView
            let selectCardArea = comp.selectCardAreaView
            selectCardArea.delegate = self
            
            if let li = list, 0 < li.count {
                comp.selectCardAreaConstraints.constant = 149
                selectCardArea.selectCardView.cardInfoList = li
                baseView.addSubview(selectCardArea)
                selectCardArea.anchorAll(equalTo: baseView)
                baseView.sizeToFit()
            }
        }
    }
}

extension FincodeCommon: FincodeSubmitButtonViewDelegate, SelectCardAreaViewDelegate {

    // 決済・カード登録・カード更新のボタンをタッチで実行され
    // 各入力コンポーネントの入力チェック、処理に応じたPresenterを返す
    func fincodeSubmitButtonView() -> BasePresenterDelegate? {
        DataHolder.instance.inputInfo = getInputInfo()
        guard let config = DataHolder.instance.config, let comp = components else { return nil }

        if comp.selectCardAreaView.selected == .newCard, validate() {
            return nil
        }
        
        switch config.useCase {
        case .registerCard:
            return cardOperatePresenter
        case .updateCard:
            return cardUpdatePresenter
        case .payment:
            return paymentPresenter
        default:
            return nil
        }
    }
    
    // 各入力コンポーネントの入力チェックを行う
    fileprivate func validate() -> Bool {
        guard let comp = components else { return false }
        var isError = false
        for item in comp.allComp() {
            let result = item.validate()
            isError = isError || result
        }
        return isError
    }
    
    // 登録済みカードと新しいカードの選択ラジオボタン切り替え時に実行される
    func didTouch(_ useCard: UseCard) {
        if useCard == .registeredCard {
            self.endEditing(true)
            componentClear()
            activeRegisteredCard()
        } else {
            activeNewCard()
        }
    }
}
