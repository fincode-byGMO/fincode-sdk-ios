//
//  FincodeCommon.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/02/03.
//

import Foundation
import UIKit

@IBDesignable
class FincodeCommon: UIView {
    
    private var mHeadingHidden: Bool = false
    private var componentDelegateList: [ComponentDelegate]?
    internal var presenter: PaymentPresenter!
    internal var config :FincodeConfiguration = FincodeConfiguration()
    
    
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
        self.presenter = PaymentPresenter(view: nil, interactor: PaymentInteractor())
        componentDelegateList = delegateList
        // setHeadingHidden()
    }
    
    var getComponentDelegateList: [ComponentDelegate] {
        get {
            guard let list = componentDelegateList else { return [] }
            return list
        }
    }
    
    private func setHeadingHidden() {
        for item in getComponentDelegateList {
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
}
