//
//  TextFormatType.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/01/31.
//

import Foundation

public enum TextFormatType: String {
    /// なし
    case none = ""
    /// 4桁ごとに半角スペース区切り
    case fourDigitsSpace = "fourDigitsSpace"
    /// 0埋め
    case twoDigitsPaddingZero = "twoDigitsPaddingZero"
}
