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
    
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var monthTextView: CustomTextField!
    @IBOutlet weak var errorMonthLabelView: UILabel!
    @IBOutlet weak var yearTextView: CustomTextField!
    @IBOutlet weak var errorYearLabelView: UILabel!
    @IBOutlet weak var boundaryLabel: UILabel!
    @IBOutlet weak var borderView: UIView!
    
    private var mLayoutType: LayoutType = .vertical
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
        
        monthTextView.validateDelegate = self
        yearTextView.validateDelegate = self
        
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
        
        errorMonthLabelView.numberOfLines = 0
        errorMonthLabelView.anchorRight(equalTo: yearTextView)
    }
    
    private func verticalLayout() {
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
                //errorMonthLabelView.numberOfLines = 2
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
    
    func customTextFieldValidate(_ view: CustomTextField) -> Bool {
        let isError = view.text?.isEmpty ?? false
        
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
            errorMonthLabelView.text = AppStrings.errorExpireMonth.value
            errorMonthLabelView.isHidden = !isError
        } else {
            errorYearLabelView.text = AppStrings.errorExpireYear.value
            errorYearLabelView.isHidden = !isError
        }
    }
    
    private func errorHorizontal(_ view: CustomTextField, isErrorMonth: Bool, isErrorYear: Bool) {
        var msg: String = ""
        if isErrorMonth, isErrorYear {
            msg = AppStrings.errorExpireMonth.value + "\n" + AppStrings.errorExpireYear.value
        } else if isErrorMonth {
            msg = AppStrings.errorExpireMonth.value
        } else if isErrorYear {
            msg = AppStrings.errorExpireYear.value
        } else {
            msg = ""
        }
        errorMonthLabelView.text = msg
        
        errorMonthLabelView.isHidden = !(isErrorMonth || isErrorYear)
        errorYearLabelView.isHidden = true
    }
}
