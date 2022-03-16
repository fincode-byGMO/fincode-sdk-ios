//
//  FincodeCardRegisterConfiguration.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/03/01.
//

import Foundation

public class FincodeCardRegisterConfiguration: FincodeConfiguration {
    /// デフォルトフラグ
    public var defaultFlag: DefaultFlg = .OFF
    
    override public init() {
        super.init()
        self.useCase = .registerCard
    }
}
