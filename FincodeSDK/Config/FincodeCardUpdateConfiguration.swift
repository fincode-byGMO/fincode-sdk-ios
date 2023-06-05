//
//  FincodeCardUpdateConfiguration.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/02/28.
//

import Foundation

public class FincodeCardUpdateConfiguration: FincodeConfiguration {
    /// カードID
    public var cardId = ""
    
    /// デフォルトフラグ
    public var defaultFlag: DefaultFlg = .ON
    
    override public init() {
        super.init()
        self.useCase = .updateCard
    }
}
