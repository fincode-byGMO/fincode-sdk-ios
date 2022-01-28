//
//  CustomPickerView.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/01/14.
//

import Foundation
import UIKit

final class CustomPickerView: UIControl {
    
    var picker: UIPickerView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        initialize()
    }
    
    private func initialize() {
        addTarget(self, action: #selector(viewTouch(_:)), for: .touchDown)
    }
    
    @objc private func viewTouch(_ sender: CustomPickerView) {
        self.becomeFirstResponder()
    }
    
    override var inputView: UIView? {
        return picker
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override var inputAccessoryView: UIView? {
        
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .extraLight))
        view.frame = CGRect(x: 0, y: 0, width: frame.width, height: 44)
        
        let closeButton = UIButton(type: .custom)
        closeButton.setTitle("閉じる", for: .normal)
        closeButton.sizeToFit()
        closeButton.addTarget(self, action: #selector(tappedCloseButton(_:)), for: .touchUpInside)
        closeButton.setTitleColor(UIColor(red: 0, green: 122/255, blue: 1, alpha: 1.0), for: .normal)
        
        view.contentView.addSubview(closeButton)
        
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.widthAnchor.constraint(equalToConstant: closeButton.frame.size.width).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: closeButton.frame.size.height).isActive = true
        closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 5).isActive = true
        closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        
        return view
    }
    
    @objc private func tappedCloseButton(_ sender: UIButton) {
        resignFirstResponder()
    }
}
