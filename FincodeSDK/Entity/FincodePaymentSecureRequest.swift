//
//  FincodePaymentSecureRequest.swift
//  fincode-ios
//
//  Created by 中嶋彰 on 2021/12/06.
//  Copyright © 2021年 GMO Payment Gateway, Inc. All rights reserved.
//

import Foundation

class FincodePaymentSecureRequest {
    
    var payType: String?
    var accessId: String?
    var id: String?
    var paRes: String?
    
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

public class FincodePaymentSecureResponse: FincodeResult {

    let shopId: String?
    let id: String?
    let payType: String?
    let status: String?
    let accessId: String?
    let processDate: Date?
    let jobCode: String?
    let itemCode: String?
    let amount: Int64?
    let tax: Int64?
    let totalAmount: Int64?
    let customerGroupId: String?
    let customerId: String?
    let cardNo: String?
    let cardId: String?
    let expire: String?
    let holderName: String?
    let cardNoHash: String?
    let method: String?
    let payTimes: Int64?
    let forward: String?
    let issuer: String?
    let transactionId: String?
    let approve: String?
    let authMaxDate: Date?
    let clientField1: String?
    let clientField2: String?
    let clientField3: String?
    let tdsType: String?
    let tds2Type: String?
    let tds2RetUrl: String?
    let tds2Status: String?
    let merchantName: String?
    let sendUrl: String?
    let subscriptionId: String?
    let errorCode: String?
    let created: Date?
    let updated: Date?
    
    init(json: JSON) {
        self.shopId = json["shop_id"].string
        self.id = json["id"].string
        self.payType = json["pay_type"].string
        self.status = json["status"].string
        self.accessId = json["access_id"].string
        self.processDate = json["process_date"].date
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
        self.authMaxDate = json["auth_max_date"].date
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
        self.created = json["created"].date
        self.updated = json["updated"].date
    }
}
