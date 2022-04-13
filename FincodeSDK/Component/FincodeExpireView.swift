//
//  FincodeExpireView.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/01/12.
//

import Foundation
import UIKit

@IBDesignable
class FincodeExpireView: UIView {
    
    @IBOutlet weak var rootView: UIView!
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var monthTextView: CustomTextField!
    @IBOutlet weak var errorMonthLabelView: UILabel!
    @IBOutlet weak var yearTextView: CustomTextField!
    @IBOutlet weak var errorYearLabelView: UILabel!
    @IBOutlet weak var boundaryLabel: UILabel!
    @IBOutlet weak var borderView: UIView!
    
    @IBOutlet weak var errorMonthLabelViewConstraints: NSLayoutConstraint!
    @IBOutlet weak var errorYearLabelViewConstraints: NSLayoutConstraint!
    
    var monthConstraints: NSLayoutConstraint?
    var yearConstraints: NSLayoutConstraint?
    
    private let monthFormatRegex: NSRegularExpression? = try? NSRegularExpression(pattern: "(^[1-9]?$)|(^0[1-9]$)|(^1[0-2]$)")
    //private let monthFormatRegex: NSRegularExpression? = try? NSRegularExpression(pattern: "^[0-9]{2}(0[1-9]|1[0-2])$")
    private var mLayoutType: LayoutType = .vertical
    private var errorMonthMsg: String = ""
    private var errorYearMsg: String = ""
    private var isErrorMonth: Bool = false
    private var isErrorYear: Bool = false
    let monthIdentifier = "monthIdentifier"
    let yearIdentifier = "yearIdentifier"
    var required: Bool = false
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        viewSetup()
        initialize()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        viewSetup()
        initialize()
    }
    
    fileprivate func initialize() {
        monthTextView.closable()
        yearTextView.closable()
        
        monthTextView.customTextFieldDelegate = self
        yearTextView.customTextFieldDelegate = self
        
        monthTextView.identifier = monthIdentifier
        yearTextView.identifier = yearIdentifier
    }
    
    private func horizontalLayout() {
        monthTextView.borderView = borderView
        yearTextView.borderView = borderView
        
        boundaryLabel.isHidden = false
        
        monthTextView.borderWidth = 0
        monthTextView.borderColor = UIColor.clear
        monthTextView.borderStyle = .none
        monthTextView.textAlignment = .center
        
        yearTextView.borderWidth = 0
        yearTextView.borderColor = UIColor.clear
        yearTextView.borderStyle = .none
        yearTextView.textAlignment = .center
        
        borderView.cornerRadius = 5
        borderView.borderWidth = 1
        borderView.borderColor = ColorController.instance.color(.borderDefault)
        
        errorYearLabelViewConstraints.isActive = false
        errorMonthLabelView.anchorRight(equalTo: yearTextView)
    }
    
    private func verticalLayout() {
        errorMonthLabelViewConstraints.isActive = false
        errorYearLabelViewConstraints.isActive = false
        
        monthConstraints = setConstraints(errorMonthLabelView, constraint: monthConstraints, isActive: true)
        yearConstraints = setConstraints(errorYearLabelView, constraint: yearConstraints, isActive: true)
        
        errorMonthLabelView.anchorRight(equalTo: monthTextView)
    }
    
    /// LayoutTypeの値のみを設定してください。
    /// ・水平配置の場合: horizontal
    /// ・垂直配置の場合: vertical
    @IBInspectable public var layoutType: String {
        get {
            return mLayoutType.rawValue
        }
        set {
            mLayoutType = LayoutType(rawValue: newValue) ?? .vertical
            if mLayoutType == .vertical {
                verticalLayout()
            } else {
                horizontalLayout()
            }
        }
    }
    
    var month: String {
        get {
            return monthTextView.text ?? ""
        }
    }
    
    var year: String {
        get {
            return yearTextView.text ?? ""
        }
    }
}

extension FincodeExpireView: ComponentDelegate {
    
    var headingHidden: Bool {
        get {
            return headingLabel.isHidden
        }
        set {
            headingLabel.isHidden = newValue
        }
    }
    
    func validate() -> Bool {
        let isMonthError = monthTextView.validete()
        let isYearError = yearTextView.validete()
        return isMonthError || isYearError
    }
    
    func clear() {
        errorMonthLabelView.isHidden = true
        errorYearLabelView.isHidden = true
        
        monthTextView.endEditingBorder(false)
        yearTextView.endEditingBorder(false)
    }
    
    func enabled(_ isEnabled: Bool) {
        monthTextView.isEnabled = isEnabled
        yearTextView.isEnabled = isEnabled
    }
}

extension FincodeExpireView: CustomTextFieldDelegate {
    func textChanged(_ view: CustomTextField) {
        // do nothing
    }
    
    func valideteTextEndEditing(_ view: CustomTextField) -> Bool {
        if mLayoutType == .vertical {
            return errorVertical(view)
        } else {
            return errorHorizontal(view)
        }
    }
    
    private func errorVertical(_ view: CustomTextField) -> Bool {
        guard let text = view.text else { return true }
        if view.identifier == monthIdentifier {
            // 有効期限(月)
            // 必須チェック
            if self.required, text.isEmpty {
                errorMonthLabelView.text = AppStrings.errorExpireMonth.value
                errorMonthLabelView.isHidden = false
                return true
            }
            // 書式チェック
            if errorMonthFormat(text) {
                errorMonthLabelView.text = AppStrings.errorExpireMonthFormat.value
                errorMonthLabelView.isHidden = false
                return true
            }
            errorMonthLabelView.text = " "
            errorMonthLabelView.isHidden = true
        } else {
            // 有効期限(年)
            // 必須チェック
            if self.required, text.isEmpty {
                errorYearLabelView.text = AppStrings.errorExpireYear.value
                errorYearLabelView.isHidden = false
                return true
            }
            errorYearLabelView.text = " "
            errorYearLabelView.isHidden = true
        }
        adjustmentConstraintVertical(errorMonth: errorMonthLabelView, errorYear: errorYearLabelView)
        
        return false
    }
    
    private func errorHorizontal(_ view: CustomTextField) -> Bool {
        guard let text = view.text else { return true }
        
        if view.identifier == monthIdentifier {
            // 有効期限(月)
            // 必須チェック
            if self.required, text.isEmpty {
                errorMonthMsg = AppStrings.errorExpireMonth.value
                isErrorMonth = true
            } else {
                // 書式チェック
                if errorMonthFormat(text) {
                    errorMonthMsg = AppStrings.errorExpireMonthFormat.value
                    isErrorMonth = true
                } else {
                    isErrorMonth = false
                }
            }
        } else {
            // 有効期限(年)
            // 必須チェック
            if self.required, text.isEmpty {
                errorYearMsg = AppStrings.errorExpireYear.value
                isErrorYear = true
            } else {
                isErrorYear = false
            }
        }

        if isErrorMonth || isErrorYear {
            var message = " "
            if isErrorMonth, isErrorYear {
                message = errorMonthMsg + "\n" + errorYearMsg
            } else if isErrorMonth {
                message = errorMonthMsg
            } else if isErrorYear {
                message = errorYearMsg
            } else {
                message = " "
            }
            errorMonthLabelView.text = message
            errorMonthLabelView.isHidden = false
            errorYearLabelView.isHidden = true
            
            return true
        } else {
            errorMonthLabelView.text = " "
            errorYearLabelView.text = " "
            errorMonthLabelView.isHidden = true
            errorYearLabelView.isHidden = true
            
            return false
        }
    }
    
    private func errorMonthFormat(_ value: String?) -> Bool {
        guard let regex = monthFormatRegex, let val = value else { return false }
        if 0 < regex.matches(in: val, range: NSRange(location: 0, length: val.count)).count {
            return false
        } else {
            return true
        }
    }
    
    // 文言が左上に表示されるように制約を制御
    private func adjustmentConstraintVertical(errorMonth: UILabel, errorYear: UILabel) {
        if getLins(errorMonth) == getLins(errorYear) {
            monthConstraints = setConstraints(errorMonth, constraint: monthConstraints, isActive: true)
            yearConstraints = setConstraints(errorYear, constraint: yearConstraints, isActive: true)
        } else if getLins(errorMonth) < getLins(errorYear) {
            monthConstraints = setConstraints(errorMonth, constraint: monthConstraints, isActive: false)
            yearConstraints = setConstraints(errorYear, constraint: yearConstraints, isActive: true)
        } else if getLins(errorMonth) > getLins(errorYear) {
            monthConstraints = setConstraints(errorMonth, constraint: monthConstraints, isActive: true)
            yearConstraints = setConstraints(errorYear, constraint: yearConstraints, isActive: false)
        } else {
            monthConstraints = setConstraints(errorMonth, constraint: monthConstraints, isActive: true)
            yearConstraints = setConstraints(errorYear, constraint: yearConstraints, isActive: true)
        }
    }
    
    private func setConstraints(_ view: UILabel, constraint: NSLayoutConstraint?, isActive: Bool) -> NSLayoutConstraint? {
        if isActive == false, let cons = constraint {
            cons.isActive = false
            return nil
        } else if isActive == true, constraint == nil {
            return view.anchorBottom(equalTo: rootView)
        }
        return constraint
    }
    
    private func getLins(_ label: UILabel) -> Int {
        label.sizeToFit()
        return Int(label.frame.height / label.font.lineHeight)
    }
}
