//
//  FincodePaymentSecureRequest.swift
//  fincode-ios
//
//  Created by 中嶋彰 on 2021/12/06.
//  Copyright © 2021年 GMO Payment Gateway, Inc. All rights reserved.
//

import Foundation

public class FincodePaymentSecureRequest {
    
    public var payType: String?
    public var accessId: String?
    public var id: String?
    public var paRes: String?
    
    public init() {
    }
    
    func parameters() -> [String: AnyObject] {
        var data: [String: AnyObject] = [:]
        setParam(&data, key: "pay_type", param: payType)
        setParam(&data, key: "access_id", param: accessId)
        setParam(&data, key: "id", param: id)
        setParam(&data, key: "pa_res", param: paRes)
        
        return data
    }
    
    private func setParam(_ data: inout [String: AnyObject], key: String, param: Any?) {
        if let p = param {
            data[key] = p as AnyObject
        }
    }
}

public class FincodePaymentSecureResponse: FincodeResponse {

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
    public let customerGroupId: String?
    public let customerId: String?
    public let cardNo: String?
    public let cardId: String?
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
    public let tdsType: String?
    public let tds2Type: String?
    public let tds2RetUrl: String?
    public let tds2Status: String?
    public let merchantName: String?
    public let sendUrl: String?
    public let subscriptionId: String?
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
        self.customerGroupId = json["customer_group_id"].string
        self.customerId = json["customer_id"].string
        self.cardNo = json["card_no"].string
        self.cardId = json["card_id"].string
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
        self.tdsType = json["tds_type"].string
        self.tds2Type = json["tds2_type"].string
        self.tds2RetUrl = json["tds2_ret_url"].string
        self.tds2Status = json["tds2_status"].string
        self.merchantName = json["merchant_name"].string
        self.sendUrl = json["send_url"].string
        self.subscriptionId = json["subscription_id"].string
        self.errorCode = json["error_code"].string
        self.created = json["created"].string
        self.updated = json["updated"].string
    }
}
