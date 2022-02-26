//
//  AppConfiguration.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/01/11.
//

import Foundation

public class AppConfiguration {
    
    fileprivate struct Constants {
        static let fileName = "Configurations"
        static let apiBaseURL = "APIBaseURL"
        static let apiMajorVersion = "APIMajorVersion"
    }
    
    static let instance = AppConfiguration()
    fileprivate init() {}
    
    var apiBaseURL: String {
        get {
            let plist = self.getPlistWithDictionary(Constants.fileName)
            let baseUrl = plist[Constants.apiBaseURL] as? String ?? ""
            let majorVersion = plist[Constants.apiMajorVersion] as? String ?? ""
            return baseUrl + majorVersion
        }
    }
    
    fileprivate func getPlistWithDictionary(_ name: String) -> NSDictionary {
        guard let path = getPlistPath(name) else { return [:] }
        return NSDictionary(contentsOfFile: path)!
    }
    
    fileprivate func getPlistPath(_ name: String) -> String? {
        guard let path = BundleUtil.instance.bundle.path(forResource: name, ofType: "plist") else { return nil }
        return path
    }
}
