//
//  DataHolder.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/03/01.
//

import Foundation

class DataHolder {
    
    static let instance = DataHolder()
    
    private var mConfig: FincodeConfiguration?
    private var mInputInfo: InputInfo?
    
    fileprivate init() {}
    
    var config: FincodeConfiguration? {
        get {
            return mConfig
        }
        set {
            mConfig = newValue
        }
    }
    
    var inputInfo: InputInfo? {
        get {
            return mInputInfo
        }
        set {
            mInputInfo = newValue
        }
    }
}
