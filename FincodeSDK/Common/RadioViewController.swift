//
//  RadioViewController.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/01/21.
//

import Foundation

class RadioViewController {
    
    fileprivate var radioViewList: [RadioView] = []
    var selectedRadioType: RadioType = .none
    
    init(_ viewList: RadioView...) {
        radioViewList = viewList
        setRadioViewDelegate()
    }
    
    fileprivate func setRadioViewDelegate() {
        for radioView in radioViewList {
            radioView.delegate = self
        }
    }
    
    private func radioUnCheckedAll() {
        for radioView in radioViewList {
            radioView.isChecked = false
        }
    }
}

extension RadioViewController: RadioViewDelegate {
    
    func radioView(_ view: RadioView, radioType: RadioType) {
        radioUnCheckedAll()
        view.isChecked = true
        selectedRadioType = radioType
    }
}
