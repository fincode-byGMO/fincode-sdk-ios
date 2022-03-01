//
//  FincodeSubmitButtonView.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/01/19.
//

import Foundation
import UIKit

protocol FincodeSubmitButtonViewDelegate: AnyObject {
    func fincodeSubmitButtonView() -> PaymentPresenterDelegate?
}

@IBDesignable
class FincodeSubmitButtonView: UIView {
    
    @IBOutlet weak var submitButton: UIButton!
    
    var delegate: FincodeSubmitButtonViewDelegate?
    
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
        submitButton.titleLabel?.lineBreakMode = .byTruncatingTail
    }
    
    func buttonTitle(_ title: String) {
        submitButton.setTitle(title, for: .normal)
    }
    
    @IBAction func didTouchButton(_ sender: Any) {
        guard let presenter = delegate?.fincodeSubmitButtonView(),
              let config = DataHolder.instance.config else { return }
        switch(config.useCase) {
        case .registerCard:
            registerCard(presenter)
        case .updateCard:
            updateCard(presenter)
        case .payment:
            payment(presenter)
        default:
            break
        }
    }
    
    // カード登録
    fileprivate func registerCard(_ presenter :BasePresenterDelegate) {
        guard let pre = presenter as? CardOperatePresenterDelegate,
              let config = DataHolder.instance.config else { return }
        pre.registerCard(config)
    }
    
    // カード更新
    fileprivate func updateCard(_ presenter :BasePresenterDelegate) {
        guard let pre = presenter as? CardOperatePresenterDelegate,
              let config = DataHolder.instance.config else { return }
        pre.updateCard(config)
    }
    
    // 決済
    fileprivate func payment(_ presenter :BasePresenterDelegate) {
        guard let pre = presenter as? PaymentPresenterDelegate,
              let config = DataHolder.instance.config  else { return }
        pre.payment(config)
    }
}

extension FincodeSubmitButtonView: ComponentDelegate {
    
    var headingHidden: Bool {
        get {
            // do nothing
            return false
        }
        set {
            // do nothing
        }
    }
    
    func validate() -> Bool {
        // do nothing
        return false
    }
}
