//
//  SelectCardAreaView.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/01/31.
//

import Foundation
import UIKit

@IBDesignable
class SelectCardAreaView: UIView {
    
    @IBOutlet weak var radioRegisteredCardView: RadioView!
    @IBOutlet weak var radioNewCardView: RadioView!
    @IBOutlet weak var selectCardView: FincodeSelectCardView!
    
    private var radioViewController: RadioViewController?
    var selectedRadio: RadioType?
    
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
        radioViewController = RadioViewController(radioRegisteredCardView, radioNewCardView)
        radioViewController?.delegate = self
    }
    
//    var cardInfoList: [CardInfo] {
//        get {
//            return selectCardView.cardInfoList
//        }
//        set {
//            selectCardView.cardInfoList = newValue
//        }
//    }
}

extension SelectCardAreaView: RadioViewControllerDelegate {
    
    func didTouch(_ view: RadioView, radioType: RadioType) {
        self.selectedRadio = radioType
    }
}
