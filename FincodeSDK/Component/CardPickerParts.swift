//
//  CardPickerParts.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/01/14.
//

import Foundation
import UIKit

@IBDesignable
class CardPickerParts: UIView {
    
    @IBOutlet weak var cardNoLabel: UILabel!
    @IBOutlet weak var expireLabel: UILabel!
    @IBOutlet weak var brandImage: UIImageView!
        
    override public init(frame: CGRect) {
        super.init(frame: frame)
        viewSetup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        viewSetup()
    }

    func setData(_ cardInfo: CardInfo) {
        cardNoLabel.text = cardInfo.cardNo
        expireLabel.text = cardInfo.expire
        brandImage.image = CardBrandType.init(brand: cardInfo.brand).cardImage
    }
}
