//
//  Request+ErrorHandler.swift
//  fincode-ios
//
//  Created by 中嶋彰 on 2021/12/15.
//  Copyright © 2021年 GMO Payment Gateway, Inc. All rights reserved.
//

import Foundation

extension DataRequest {

    @discardableResult
    func responseJSONWithErrorHandler(completionHandler: @escaping (DataResponse<Any>) -> Void)
        -> Self
    {
        return self.responseJSON { response in
            completionHandler(response)
        }
    }

    @discardableResult
    func responseWithErrorHandler(
        queue: DispatchQueue? = nil,
        completionHandler: @escaping (DefaultDataResponse) -> Void) -> Self
    {
        return response(queue: queue) { response in
            completionHandler(response)
        }
    }
}
