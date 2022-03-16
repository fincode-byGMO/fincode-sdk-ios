//
//  FincodeSelectCard.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/01/14.
//

import Foundation
import UIKit

@IBDesignable
class FincodeSelectCardView: UIView {
    
    @IBOutlet weak var selectedCardInfo: UIView!
    @IBOutlet weak var pickerView: CustomPickerView!
    
    fileprivate var mCardInfoList: [CardInfo] = []
    fileprivate var selected: CardInfo?
    
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
        let pi = UIPickerView()
        pi.dataSource = self
        pi.delegate = self
        pickerView.picker = pi
    }
    
    var cardInfoList: [CardInfo] {
        get {
            return mCardInfoList
        }
        set {
            mCardInfoList = newValue
        }
    }
    
    var selectedCard: CardInfo? {
        get {
            return selected
        }
    }
}

extension FincodeSelectCardView: UIPickerViewDelegate, UIPickerViewDataSource {
    
    // 列数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // 行数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cardInfoList.count
    }
    
    // 1行ごとの初期化
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        return getParts(cardInfoList[row])
    }
    
    // 選択後
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let value = cardInfoList[row]
        selected = value
        applyCardInfo(getParts(value))
    }
    
    func applyCardInfo(_ parts: CardPickerParts) {
        removeAllSubviews(selectedCardInfo)
        parts.isUserInteractionEnabled = false
        selectedCardInfo.addSubview(parts)
        parts.anchorAll(equalTo: selectedCardInfo)
    }
    
    fileprivate func removeAllSubviews(_ view: UIView){
        let subviews = view.subviews
        for subview in subviews {
            subview.removeFromSuperview()
        }
    }
    
    fileprivate func getParts(_ info: CardInfo) -> CardPickerParts {
        let parts = CardPickerParts()
        parts.setData(info)
        
        return parts
    }
}
