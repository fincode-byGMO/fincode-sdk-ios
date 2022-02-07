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
    
    private let monthFormatRegex: NSRegularExpression? = try? NSRegularExpression(pattern: "(^[1-9]$)|(^0[1-9]$)|(^1[0-2]$)")
    private var mLayoutType: LayoutType = .vertical
    private var errorMonthMsg: String = ""
    private var isErrorMonth: Bool = false
    private var isErrorYear: Bool = false
    let monthIdentifier = "monthIdentifier"
    let yearIdentifier = "yearIdentifier"
    
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
}

extension FincodeExpireView: CustomTextFieldDelegate {
    func textChanged(_ view: CustomTextField) {
        // do nothing
    }
    
    func valideteTextEndEditing(_ view: CustomTextField) -> Bool {
        guard let text = view.text else { return false }
        var isError: Bool = text.isEmpty
        if view.identifier == monthIdentifier {
            isError = isError || errorMonthFormat(text)
        }
        
        if view.identifier == monthIdentifier {
            isErrorMonth = isError
        } else {
            isErrorYear = isError
        }
        
        if mLayoutType == .vertical {
            errorVertical(view, isError: isError)
        } else {
            errorHorizontal(view, isErrorMonth: isErrorMonth, isErrorYear: isErrorYear)
        }
        
        return mLayoutType == .vertical ? isError : isErrorMonth || isErrorYear
    }
    
    private func errorVertical(_ view: CustomTextField, isError: Bool) {
        if view.identifier == monthIdentifier {
            errorMonthLabelView.text = getMonthErrorMessage(view.text)
            errorMonthLabelView.isHidden = !isError
            setFormatErrorColor(view)
        } else {
            errorYearLabelView.text = getYearErrorMessage(view.text)
            errorYearLabelView.isHidden = !isError
        }
        adjustmentConstraintVertical(errorMonth: errorMonthLabelView, errorYear: errorYearLabelView)
    }
    
    private func errorHorizontal(_ view: CustomTextField, isErrorMonth: Bool, isErrorYear: Bool) {
        var result: String = ""
        if view.identifier == monthIdentifier {
            errorMonthMsg = getMonthErrorMessage(view.text)
        }
        
        if isErrorMonth, isErrorYear {
            result = errorMonthMsg + "\n" + AppStrings.errorExpireYear.value
        } else if isErrorMonth {
            result = errorMonthMsg
        } else if isErrorYear {
            result = AppStrings.errorExpireYear.value
        } else {
            result = ""
        }
        errorMonthLabelView.text = result
        errorMonthLabelView.isHidden = !(isErrorMonth || isErrorYear)
        errorYearLabelView.isHidden = true
        setFormatErrorColor(view)
    }
    
    private func setFormatErrorColor(_ view: CustomTextField) {
        guard let value = view.text else { return }
        if errorMonthFormat(value) {
            view.textColor = UIColor.red
        } else {
            view.textColor = UIColor.black
        }
    }
    
    private func getMonthErrorMessage(_ value: String?) -> String {
        guard let val = value else { return "" }
        if val.isEmpty {
            return AppStrings.errorExpireMonth.value
        } else if errorMonthFormat(val) {
            return AppStrings.errorExpireMonthFormat.value
        } else {
            // ブランクだと表示領域の高さだけ縮まるためダミーを返す
            return " "
        }
    }
    
    private func getYearErrorMessage(_ value: String?) -> String {
        guard let val = value else { return "" }
        if val.isEmpty {
            return AppStrings.errorExpireYear.value
        } else {
            // ブランクだと表示領域の高さだけ縮まるためダミーを返す
            return " "
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
            //view.removeConstraint(cons)
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
