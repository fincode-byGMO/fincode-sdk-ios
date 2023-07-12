//
//  FincodeApplePayRequest.swift
//  FincodeSDK
//
//  Created by m.ito on 2023/06/14.
//

import Foundation

public class FincodeApplePayRequest {
    
    public var payType: String?
    public var accessId: String?
    public var id: String?
    public var token: String?
    public var customerId: String?
    
    public init() {
    }
    
    func parameters() -> [String: AnyObject] {
        var data: [String: AnyObject] = [:]
        setParam(&data, key: "pay_type", param: payType)
        setParam(&data, key: "access_id", param: accessId)
        setParam(&data, key: "id", param: id)
        setParam(&data, key: "token", param: token)
        setParam(&data, key: "customer_id", param: customerId)
        return data
    }
    
    private func setParam(_ data: inout [String: AnyObject], key: String, param: Any?) {
        if let p = param {
            data[key] = p as AnyObject
        }
    }
}

public class FincodeApplePayResponse: FincodeResponse {

    public let shopId: String?
    public let id: String?
    public let payType: String?
    public let status: String?
    public let accessId: String?
    public let processDate: String?
    public let jobCode: String?
    public let itemCode: String?
    public let amount: Int64?
    public let tax: Int64?
    public let totalAmount: Int64?
    public let customerId: String?
    public let cardNo: String?
    public let expire: String?
    public let holderName: String?
    public let cardNoHash: String?
    public let method: String?
    public let payTimes: Int64?
    public let forward: String?
    public let issuer: String?
    public let transactionId: String?
    public let approve: String?
    public let authMaxDate: String?
    public let clientField1: String?
    public let clientField2: String?
    public let clientField3: String?
    public let sendUrl: String?
    public let brand: String?
    public let errorCode: String?
    public let created: String?
    public let updated: String?
    
    init(json: JSON) {
        self.shopId = json["shop_id"].string
        self.id = json["id"].string
        self.payType = json["pay_type"].string
        self.status = json["status"].string
        self.accessId = json["access_id"].string
        self.processDate = json["process_date"].string
        self.jobCode = json["job_code"].string
        self.itemCode = json["item_code"].string
        self.amount = json["amount"].int64
        self.tax = json["tax"].int64
        self.totalAmount = json["total_amount"].int64
        self.customerId = json["customer_id"].string
        self.cardNo = json["card_no"].string
        self.expire = json["expire"].string
        self.holderName = json["holder_name"].string
        self.cardNoHash = json["card_no_hash"].string
        self.method = json["method"].string
        self.payTimes = json["pay_times"].int64
        self.forward = json["forward"].string
        self.issuer = json["issuer"].string
        self.transactionId = json["transaction_id"].string
        self.approve = json["approve"].string
        self.authMaxDate = json["auth_max_date"].string
        self.clientField1 = json["client_field_1"].string
        self.clientField2 = json["client_field_2"].string
        self.clientField3 = json["client_field_3"].string
        self.sendUrl = json["send_url"].string
        self.brand = json["brand"].string
        self.errorCode = json["error_code"].string
        self.created = json["created"].string
        self.updated = json["updated"].string
    }
}
