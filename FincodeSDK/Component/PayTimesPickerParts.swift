//
//  PayTimesPickerParts.swift
//  FincodeSDK_Develop
//
//  Created by 中嶋彰 on 2022/03/31.
//

import Foundation
import UIKit

@IBDesignable
class PayTimesPickerParts: UIView {

    @IBOutlet weak var labelView: UILabel!
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        viewSetup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        viewSetup()
    }
}
