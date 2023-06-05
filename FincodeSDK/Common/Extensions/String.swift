//
//  String.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/03/18.
//

import Foundation

extension String {
    
    var urlEncoded: String {
        // 変換対象外とする文字列（英数字と-._~）
        let allowedCharacters = NSCharacterSet.alphanumerics.union(.init(charactersIn: "-._~"))
        if let encodedText = self.addingPercentEncoding(withAllowedCharacters: allowedCharacters) {
            return encodedText
        }
        
        return ""
    }
    
    var urlDecoded: String {
        if let decodedText = self.removingPercentEncoding {
            return decodedText
        }
        
        return ""
    }
}
