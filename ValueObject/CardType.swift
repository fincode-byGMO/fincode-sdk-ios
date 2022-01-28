//
//  CardType.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/01/19.
//

import Foundation
import UIKit

enum CardType: String {
    
    case none = ""
    case visa = "card_visa_ic"
    case master = "card_master_ic"
    case jcb = "card_jcb_ic"
    case dinersClub = "card_diners-club_ic"
    case americanXpress = "card_american-xpress_ic"
    
    var cardImage: UIImage? {
        get {
            switch(self) {
            case .visa, .master, .jcb, .dinersClub, .americanXpress:
                return UIImage(named: self.rawValue)
            default:
                return nil
            }
        }
    }
    
    func getCardType(_ value: String) {
        // TODO カード番号からブランド特定する処理を実装する
    }
}
