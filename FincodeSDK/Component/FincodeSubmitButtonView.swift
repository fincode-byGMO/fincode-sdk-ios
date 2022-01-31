//
//  FincodeSubmitButtonView.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/01/19.
//

import Foundation
import UIKit

protocol FincodeSubmitButtonViewDelegate: AnyObject {
    func fincodeSubmitButtonView() -> PaymentPresenter?
}

@IBDesignable
class FincodeSubmitButtonView: UIView {
    
    @IBOutlet weak var submitButton: UIButton!
    
    private var useCaseType: UseCase = .none
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
    }
    
    var useCase: UseCase {
        get {
            return useCaseType
        }
        set {
            useCaseType = newValue
            submitButton.setTitle(useCaseType.rawValue, for: .normal)
        }
    }
    
    @IBAction func didTouchButton(_ sender: Any) {
        
        guard let presenter: PaymentPresenter = delegate?.fincodeSubmitButtonView() else { return }
        
        switch(useCase) {
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
    
    fileprivate func registerCard(_ presenter :PaymentPresenter) {
        
    }
    
    fileprivate func updateCard(_ presenter :PaymentPresenter) {
        
    }
    
    fileprivate func payment(_ presenter :PaymentPresenter) {
        presenter.didTapPayment()
    }
}
