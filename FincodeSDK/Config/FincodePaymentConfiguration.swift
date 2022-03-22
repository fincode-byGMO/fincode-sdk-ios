//
//  FincodePaymentConfiguration.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/02/28.
//

import Foundation

public class FincodePaymentConfiguration: FincodeConfiguration {
    /// 決済種別
    public var payType: String = ""
    
    /// 取引ID
    public var accessId: String = ""
    
    /// オーダーID
    public var id: String = ""
    
    /// カードID
    public var cardId: String = ""
    
    /// 3Dセキュア認証 加盟店様 URL
    public var termUrl: String = ""
    
    override public init() {
        super.init()
        self.useCase = .payment
    }
}
