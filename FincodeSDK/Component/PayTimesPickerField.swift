//
//  PayTimesPickerField.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/02/26.
//

import Foundation
import UIKit

class PayTimesPickerField: UITextField {
    
    struct Item {
        let key: Int
        let value: String
        init(key: Int, value: String) {
            self.key = key
            self.value = value
        }
    }
    
    private let picker = UIPickerView()
    var items: [Item] = []
    var mExtText: Int?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        initialize()
    }
    
    private func initialize() {
        closable()
        picker.delegate = self
        picker.dataSource = self
        inputView = picker
        
        items.append(Item(key: 0, value: "一括払い"))
        items.append(Item(key: 1, value: "リボ払い"))
        
        if let value = AppConfiguration.instance.payTimes {
            value.forEach { payTime in
                if let k = payTime as? Int  {
                    items.append(Item(key: k, value: "分割 \(payTime)回"))
                }
            }
        }
        
        if 0 < items.count {
            items.sort { $0.key < $1.key }
        }
    }
    
    // 入力カーソル非表示
    override func caretRect(for position: UITextPosition) -> CGRect {
        return CGRect.zero
    }

//    // 範囲選択カーソル非表示
//    override func selectionRects(for range: UITextRange) -> [UITextSelectionRect] {
//        return []
//    }
    
    // コピー・ペースト・選択等のメニュー非表示
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return false
    }
    
    private func select(_ row: Int) {
        text = String(items[row].value)
        mExtText = items[row].key
    }
    
    func selectRow(_ row: Int) {
        picker.selectRow(row, inComponent: 0, animated: true)
        select(row)
    }
    
    var extText: Int? {
        get {
            return mExtText
        }
    }
}

extension PayTimesPickerField: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return items.count
    }

    // 1行ごとの初期化
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let view = PayTimesPickerParts()
        view.labelView.textAlignment = .center
        view.labelView.text = items[row].value
        view.labelView.font = view.labelView.font.withSize(20)
        return view.labelView
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        select(row)
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 200
    }
}

