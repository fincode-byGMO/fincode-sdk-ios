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
        
        // DEBUG用 削除予定
        let cardInfoList = [CardInfo("5555 7777 8888 6666", "09/23"), CardInfo("3333 5555 6666 8888", "10/24")]
        selectCardView.setData(cardInfoList)
    }
}
