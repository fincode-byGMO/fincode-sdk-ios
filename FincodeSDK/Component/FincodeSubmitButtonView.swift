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
    
    private var mConfig: FincodeConfiguration?
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
    
    var config: FincodeConfiguration? {
        get {
            return mConfig
        }
        set {
            mConfig = newValue
            submitButton.setTitle(mConfig?.useCase.title, for: .normal)
        }
    }
    
    @IBAction func didTouchButton(_ sender: Any) {
        guard let presenter = delegate?.fincodeSubmitButtonView(), let config = mConfig else { return }
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
    
    fileprivate func registerCard(_ presenter :PaymentPresenterDelegate) {
        
    }
    
    fileprivate func updateCard(_ presenter :PaymentPresenterDelegate) {
        
    }
    
    fileprivate func payment(_ presenter :PaymentPresenterDelegate) {
        presenter.payment()
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
