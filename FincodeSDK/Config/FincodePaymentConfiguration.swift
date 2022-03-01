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
    
    /// 支払方法
    ///
    /// "1" : 一括
    ///
    /// "2" : 分割
    ///
    /// "3" : ボーナス一括
    ///
    /// "4" : ボーナス分割
    ///
    /// "5" : リボ
    public var method: String?
    
    /// 決済する対象の取引IDを設定
    public var accessId: String = ""
    
    /// オーダーIDを設定
    ///
    /// 利用目的が決済の場合、決済する対象のオーダーIDを設定
    public var id: String = ""
}
