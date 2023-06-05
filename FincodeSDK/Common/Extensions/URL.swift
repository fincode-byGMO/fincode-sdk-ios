//
//  URL.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/03/08.
//

import Foundation

extension URL {
    func appendQueryParameters(_ parameters: [String: Any]) -> URL {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = parameters.compactMap { URLQueryItem(name: $0.key, value: $0.value as? String) }
        return components!.url!
    }
}
