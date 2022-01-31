//
//  BaseView.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/01/11.
//

import UIKit

@IBDesignable
extension UIView {
    
    func viewSetup() {
        
        let name = String(describing: type(of: self))
        let nib = UINib(nibName: name, bundle: Bundle(for: type(of: self)))
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else {
            fatalError("Failed to load nib")
        }
        
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }
    
    func anchorAll(equalTo: UIView) {
        // 対象のViewの四辺にアンカーを設定
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: equalTo.topAnchor, constant: 0).isActive = true
        leftAnchor.constraint(equalTo: equalTo.leftAnchor, constant: 0).isActive = true
        bottomAnchor.constraint(equalTo: equalTo.bottomAnchor, constant: 0).isActive = true
        rightAnchor.constraint(equalTo: equalTo.rightAnchor, constant: 0).isActive = true
    }
    
    func setViewGoneVertical() {
        self.isHidden = true
        self.addConstraint(NSLayoutConstraint(item: self,
                                              attribute: NSLayoutConstraint.Attribute.height,
                                              relatedBy: NSLayoutConstraint.Relation.equal,
                                              toItem: nil,
                                              attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                                              multiplier: 1,
                                              constant: 0))
    }
    
    func isBorderError(_ status: Bool) {
        if status {
            borderColor = ColorController.instance.color(.borderError)
        } else {
            borderColor = ColorController.instance.color(.borderDefault)
        }
    }
    
    /// 角の丸みを取得・設定
    @IBInspectable public var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
        }
    }
    
    /// 枠線の太さを取得・設定
    @IBInspectable public var borderWidth: CGFloat {
        get {
            return self.layer.borderWidth
        }
        set {
            self.layer.borderWidth = newValue
        }
    }
    
    /// 枠線の色を取得・設定
    @IBInspectable public var borderColor: UIColor {
        get {
            if let cgColor = self.layer.borderColor {
                return UIColor(cgColor: cgColor)
            } else {
                return UIColor.clear
            }
        }
        set {
            self.layer.borderColor = newValue.cgColor
        }
    }
    
    /// 背景色を取得・設定
    @IBInspectable public var backgroundColor: UIColor {
        get {
            if let cgColor = self.layer.backgroundColor {
                return UIColor(cgColor: cgColor)
            } else {
                return UIColor.clear
            }
        }
        set {
            self.layer.backgroundColor = newValue.cgColor
        }
    }
}
