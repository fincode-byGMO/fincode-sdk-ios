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
        let type = CardBrandType.init(brand: cardInfo.brand)
        cardNoLabel.text = type.delimit(cardInfo.cardNo)
        expireLabel.text = format(cardInfo.expire)
        brandImage.image = type.cardImage
    }
    
    func format(_ value: String) -> String {
        if !value.isEmpty, value.count == 4 {
            let year = String(value[value.startIndex...value.index(value.startIndex, offsetBy: 1)])
            let month = String(value[value.index(value.startIndex, offsetBy: 2)...value.index(value.startIndex, offsetBy: 3)])
            return "\(month)/\(year)"
        } else {
            return value
        }
    }
}
