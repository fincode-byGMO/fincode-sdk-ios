//
//  UIControl.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/03/18.
//

import Foundation
import UIKit

extension UIControl {
    
    func completedButton() -> UIToolbar {
        let barButton = UIBarButtonItem(title: "完了", style: .done, target: self, action: #selector(UITextField.didTouchCompleted(_:)))
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 44))
        toolbar.items = [barButton]
        
        return toolbar
    }
    
    @objc func didTouchCompleted(_ sender: AnyObject) {
        self.resignFirstResponder()
    }
}
