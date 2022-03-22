//
//  FincodeCommon.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/02/03.
//

import Foundation
import UIKit

protocol FincodeCommonDelegate: AnyObject {
    func setCardList(_ list: [CardInfo]?)
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
        
        init(cardNoView: FincodeCardNoView, expireView: FincodeExpireView, securityCodeView: FincodeSecurityCodeView,
             submitButtonView: FincodeSubmitButtonView, holderNameView: FincodeHolderNameView, payTimesView: FincodePayTimesView,
             selectCardAreaView: SelectCardAreaView, selectCardAreaBaseView: UIView, selectCardAreaConstraints: NSLayoutConstraint) {
            self.cardNoView = cardNoView
            self.expireView = expireView
            self.securityCodeView = securityCodeView
            self.submitButtonView = submitButtonView
            self.holderNameView = holderNameView
            self.payTimesView = payTimesView
            self.selectCardAreaView = selectCardAreaView
            self.selectCardAreaBaseView = selectCardAreaBaseView
            self.selectCardAreaConstraints = selectCardAreaConstraints
        }
        
        func list() -> [ComponentDelegate] {
            return [cardNoView, expireView, securityCodeView, holderNameView]
        }
    }
    
    private var mHeadingHidden: Bool = false
    private var mDynamicLogDisplay: Bool = false
    private var mHolderNameHidden: Bool = false
    private var mMethodHidden: Bool = false
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
        componentEnabled(false)
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
    
    private func initComponent(_ delegate: ResultDelegate) {
        guard let config = DataHolder.instance.config,
              let button = components?.submitButtonView,
              let parentViewController = parentViewController else { return }
        
        button.buttonTitle(config.useCase.title)
        switch config.useCase {
        case .registerCard:
            gonePayTimesView()
            cardOperatePresenter = CardRegisterPresenter(interactor: CardOperateInteractor())
            cardOperatePresenter?.externalResultDelegate = delegate
        case .updateCard:
            gonePayTimesView()
            cardUpdatePresenter = CardUpdatePresenter(interactor: CardOperateInteractor())
            cardUpdatePresenter?.externalResultDelegate = delegate
        case .payment:
            paymentPresenter = PaymentPresenter(interactor: PaymentInteractor(), interactorCard: CardOperateInteractor(), router: PaymentRouter(parentViewController), view: self)
            paymentPresenter?.externalResultDelegate = delegate
            paymentPresenter?.cardInfoList(config)
        default:
            break
        }
    }
    
    private func componentEnabled(_ isEnabled: Bool) {
        guard let comp = components else { return }
        for item in comp.list() {
            item.enabled(isEnabled)
        }
    }
    
    private func componentClear() {
        guard let comp = components else { return }
        for item in comp.list() {
            item.clear()
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
            for item in comp.list() {
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
    
    func setCardList(_ list: [CardInfo]?) {
        guard let comp = components else { return }
        
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
        for item in comp.list() {
            let result = item.validate()
            isError = isError || result
        }
        return isError
    }
    
    // 登録済みカードと新しいカードの選択ラジオボタン切り替え時に実行される
    func didTouch(_ useCard: UseCard) {
        guard let comp = components else { return }
        if useCard == .registeredCard {
            self.endEditing(true)
            componentClear()
            componentEnabled(false)
            comp.selectCardAreaView.selectCardView.enabled(true)
        } else {
            componentEnabled(true)
            comp.selectCardAreaView.selectCardView.enabled(false)
        }
    }
}
