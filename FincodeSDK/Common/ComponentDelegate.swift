//
//  ComponentDelegate.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/01/28.
//

import Foundation
import UIKit

protocol ComponentDelegate: AnyObject {
    /// バリデーション チェック
    func validate() -> Bool
    /// バリデーション チェックの表示クリア
    func clear()
    /// 入力欄の活性・非活性
    func enabled(_ isEnabled: Bool)
    /// 見出しの表示・非表示
    var headingHidden: Bool { get set }
}
