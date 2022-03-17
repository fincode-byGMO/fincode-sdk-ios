//
//  FincodeSubmitButtonView.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/01/19.
//

import Foundation
import UIKit

protocol FincodeSubmitButtonViewDelegate: AnyObject {
    func fincodeSubmitButtonView() -> BasePresenterDelegate?
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
        guard let presenter = delegate?.fincodeSubmitButtonView(), let inputInfo = DataHolder.instance.inputInfo else { return }
        guard let config = DataHolder.instance.config else {
            showAlert("no config")
            return
        }
        presenter.execute(config, inputInfo: inputInfo)
    }
}
