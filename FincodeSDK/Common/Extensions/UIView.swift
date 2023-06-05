//
//  UIView.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/01/11.
//

import UIKit

@IBDesignable
extension UIView {
    
    func viewSetup() {
        
        let name = String(describing: type(of: self))
        // let nib = UINib(nibName: name, bundle: Bundle(for: type(of: self)))
        let nib = UINib(nibName: name, bundle: BundleUtil.instance.bundle)
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
    
    func anchorRight(equalTo: UIView) {
        rightAnchor.constraint(equalTo: equalTo.rightAnchor, constant: 0).isActive = true
    }
    
    func anchorBottom(equalTo: UIView) -> NSLayoutConstraint {
        let constraint: NSLayoutConstraint = bottomAnchor.constraint(equalTo: equalTo.bottomAnchor, constant: 0)
        constraint.isActive = true
        return constraint
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
    
    func setViewGoneHorizontal() {
        self.isHidden = true
        self.addConstraint(NSLayoutConstraint(item: self,
                                              attribute: NSLayoutConstraint.Attribute.width,
                                              relatedBy: NSLayoutConstraint.Relation.equal,
                                              toItem: nil,
                                              attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                                              multiplier: 1,
                                              constant: 0))
    }
    
    func showAlert(_ message: String) {
        showMessage(message, title: "エラー")
    }
    
    func showMessage(_ message: String, title: String = "",
                     type: MessageDialogViewController.ButtonType = .close, action: ((UIButton) -> Void)? = nil) {
        guard let vc = parentViewController else { return }
        guard let view = MessageDialogViewController.instantiateViewControllerFromStoryboard() as? MessageDialogViewController else { return }
        view.modalPresentationStyle = .overCurrentContext
        view.dialogTitle = title
        view.dialogMessage = message
        view.buttonType = type
        view.action = action
        vc.present(view, animated: false, completion: nil)
    }
    
    // 自身を配置しているViewControllerを取得する
    var parentViewController: UIViewController? {
        var parent: UIResponder? = self
        while let next = parent?.next {
            if let viewController = next as? UIViewController {
                return viewController
            }
            parent = next
        }
        return nil
    }
    
    @objc func isBorderError(_ status: Bool) {
        if status {
            borderColor = ColorController.instance.color(.borderError)
        } else {
            borderColor = ColorController.instance.color(.borderDefault)
        }
    }
    
    func isBorderFocus(_ status: Bool) {
        if status {
            borderColor = ColorController.instance.color(.primary)
        } else {
            borderColor = ColorController.instance.color(.borderDefault)
        }
    }
    
    func removeAllSubviews(){
        for subview in self.subviews {
            subview.removeFromSuperview()
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
    @IBInspectable public var extBackgroundColor: UIColor {
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
