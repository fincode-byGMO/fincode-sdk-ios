//
//  SettingUseCase.swift
//  fincode-ios
//
//  Created by 中嶋彰 on 2021/12/16.
//  Copyright © 2021年 GMO Payment Gateway, Inc. All rights reserved.
//

import Foundation
import UIKit

//public class SettingUseCase {

//    fileprivate struct Constants {
//        static let apiVersion = "Api-Version"
//        static let authorization = "Authorization"
//        static let id = "id"
//    }

//    /// 認証方式およびAPIキー
//    public var authorizationMethod: AuthorizationMethod?
//    /// マイナーバージョン
//    public var apiVersion: String?
//
//    public static let sharedInstance = SettingUseCase()
//    fileprivate init() {}
//
//    /// HTTPリクエスト情報
//    var config: RequestConfiguration?

//    var requestHeader: [String: String] {
//        get {
//            var header: [String: String] = [:]
//            // header情報のチェック
//            guard let cnf = self.config, let auth = cnf.authorizationMethod else {
//                //throw FcConfigurationException(kind: .apiKeyNotSetting)
//                logger("APIKey", "error : \(ErrorKind.apiKeyNotSetting.rawValue)")
//                return header
//            }
//
//            setHeader(key: Constants.authorization, value: auth.authorization, header: &header)
//            setHeader(key: Constants.apiVersion, value: cnf.apiVersion, header: &header)
//
//            return header
//        }
//    }
    
//    public func setHeader(key: String, value: String?, header: inout [String: String]) {
//        guard let val = value else { return }
//        header[key] = val
//    }

//    public func getPlistWithDictionary(_ name: String) -> NSDictionary {
//        guard let path = getPlistPath(name) else { return [:] }
//        return NSDictionary(contentsOfFile: path)!
//    }
//
//    func getPlistPath(_ name: String) -> String? {
//        let bundle = Bundle(for: type(of: self))
//        guard let path = bundle.path(forResource: name, ofType: "plist") else { return nil }
//
//        return path
//    }
//}
