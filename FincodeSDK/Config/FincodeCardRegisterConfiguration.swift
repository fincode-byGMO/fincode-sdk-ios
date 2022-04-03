//
//  FincodeCardRegisterConfiguration.swift
//  FincodeSDK
//
//  Created by fincode on 2022/03/01.
//

import Foundation

public class FincodeCardRegisterConfiguration: FincodeConfiguration {
    /// デフォルトフラグ
    public var defaultFlag: DefaultFlg = .ON
    
    override public init() {
        super.init()
        self.useCase = .registerCard
    }
}
