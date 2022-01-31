//
//  UITextField .swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/01/31.
//

import UIKit

@IBDesignable
extension UITextField {
    
    func isPlaceholderError(_ status: Bool) {
        if status {
            placeholderColor = ColorController.instance.color(.borderError)
        } else {
            placeholderColor = ColorController.instance.color(.borderDefault)
        }
    }
    
    /// プレイスホルダーの色を設定
    @IBInspectable public var placeholderColor: UIColor? {
        get {
            // 色の取得ができないため
            return nil
        }
        set {
            if let color = newValue {
                self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "",
                                                                attributes: [NSAttributedString.Key.foregroundColor: color])
            }
        }
    }
}
