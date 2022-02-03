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
//    /// 見出しの表示・非表示
//    func headingHidden(_ isHidden: Bool)
    var headingHidden: Bool { get set }
}
