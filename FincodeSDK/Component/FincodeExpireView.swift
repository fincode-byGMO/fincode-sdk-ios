//
//  FincodeExpireView.swift
//  FincodeSDK
//
//  Created by fincode on 2022/01/12.
//

import Foundation
import UIKit

@IBDesignable
class FincodeExpireView: UIView {
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        viewSetup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        viewSetup()
    }
}
