//
//  APIEndpoint.swift
//  fincode-ios
//
//  Created by 中嶋彰 on 2021/12/15.
//  Copyright © 2021年 GMO Payment Gateway, Inc. All rights reserved.
//

enum APIEndpoint {
    
    /// 決済登録
    case register(data: [String: AnyObject], header: [String: String])
    /// 決済実行
    case payment(id: String, data: [String: AnyObject], header: [String: String])
    /// カード登録
    case cardRegister(customer_id: String, data: [String: AnyObject], header: [String: String])
    /// カード更新
    case cardUpdate(customer_id: String, id: String, data: [String: AnyObject], header: [String: String])
    
    // ///////////////////////////////
    // endpoint
    var urlString: URLConvertible {
        var path: String
        
        switch self {
        case .register(_, _):
            path = "/payments"
            
        case .payment(let id, _, _):
            path = "/payments/\(id)"
            
        case .cardRegister(let customer_id, _, _):
            path = "/customers/\(customer_id)/cards"
            
        case .cardUpdate(let customer_id, let id, _, _):
            path = "/customers/\(customer_id)/cards/\(id)"
        }
        
        return APIEndpoint.urlString(path)
    }
    
    // ///////////////////////////////
    // request
    var apiRequest: DataRequest {
        switch self {
        case .register(data: let data, header: let header):
            return executeApi(method: .post, data: data, headers: header)
            
        case .payment(_, let data, let header):
            return executeApi(method: .put, data: data, headers: header)
            
        case .cardRegister(_, data: let data, header: let header):
            return executeApi(method: .post, data: data, headers: header)
            
        case .cardUpdate(_, _, data: let data, header: let header):
            return executeApi(method: .put, data: data, headers: header)
        }
    }
    
    static fileprivate func urlString(_ path: String) -> URLConvertible {
        return ApiConfiguration.instance.apiBaseURL.appendingPathComponent(path).absoluteString
    }
    
    func executeApi(
        method: HTTPMethod,
        data: [String: AnyObject]! = nil,
        headers: [String: String])
    -> DataRequest
    {
        let req: DataRequest = ApiManager.sharedInstance
            .request(urlString,
                     method: method,
                     parameters: data,
                     encoding: URLEncoding.default,
                     headers: headers)
            .validate()
        
        req.responseString { responce in
            if responce.result.isSuccess {
                logger(req, "  request: \(String(describing: data))", "  response: \(responce)", function: "api")
            } else {
                let _: () -> String = {
                    if let response = responce.data,
                       let string = NSString(data: response, encoding: String.Encoding.utf8.rawValue)
                    {
                        return String(string)
                    }
                    return "nil"
                }
                logger(req, "  request: \(String(describing: data))", "  response: \(responce)", function: "api")
            }
        }
        
        return req
    }
    
}
