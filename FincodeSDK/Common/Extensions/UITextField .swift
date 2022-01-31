//
//  UITextField .swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/01/31.
//

import UIKit

@IBDesignable
extension UITextField {
    
    // TODO 見直す
    func closable() {
        let barButton = UIBarButtonItem(barButtonSystemItem: .edit,
            target: self, action: #selector(UITextField.didTouchDone(_:)))
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 44))
        toolbar.items = [barButton]
        self.inputAccessoryView = toolbar
    }
    
    @objc func didTouchDone(_ sender: AnyObject) {
        self.resignFirstResponder()
    }
    
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
