//
//  FincodePaypayRequest.swift
//  FincodeSDK
//
//  Created by admin on 2023/07/28.
//

import Foundation

public class FincodePaypayRequest {
    
    public var payType: String?
    public var accessId: String?
    public var id: String?
    public var customerId: String?
    public var redirectUrl: String?
    public var redirectType: String?
    public var userAgent: String?
    
    public init() {
    }
    
    func parameters() -> [String: AnyObject] {
        var data: [String: AnyObject] = [:]
        setParam(&data, key: "pay_type", param: payType)
        setParam(&data, key: "access_id", param: accessId)
        setParam(&data, key: "id", param: id)
        setParam(&data, key: "customer_id", param: customerId)
        setParam(&data, key: "redirect_url", param: redirectUrl)
        setParam(&data, key: "redirect_type", param: redirectType)
        setParam(&data, key: "user_agent", param: userAgent)
        
        return data
    }
    
    private func setParam(_ data: inout [String: AnyObject], key: String, param: Any?) {
        if let p = param {
            data[key] = p as AnyObject
        }
    }
}

public class FincodePaypayResponse: FincodeResponse {

    public let shopId: String?
    public let id: String?
    public let payType: String?
    public let status: String?
    public let accessId: String?
    public let processDate: String?
    public let jobCode: String?
    public let amount: Int64?
    public let tax: Int64?
    public let totalAmount: Int64?
    public let customerId: String?
    public let codeExpiryDate: String?
    public let authMaxDate: String?
    public let orderDescription: String?
    public let captureDescription: String?
    public let updateDescription: String?
    public let cancelDescription: String?
    public let redirectUrl: String?
    public let redirectType: String?
    public let clientField1: String?
    public let clientField2: String?
    public let clientField3: String?
    public let storeId: String?
    public let codeId: String?
    public let codeUrl: String?
    public let paymentId: String?
    public let paypayResultCode: String?
    public let merchantPaymentId: String?
    public let merchantCaptureId: String?
    public let merchantUpdateId: String?
    public let merchantRevertId: String?
    public let merchantRefundId: String?
    public let paymentDate: String?
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
        self.amount = json["amount"].int64
        self.tax = json["tax"].int64
        self.totalAmount = json["total_amount"].int64
        self.customerId = json["customer_id"].string
        self.codeExpiryDate = json["code_expiry_date"].string
        self.authMaxDate = json["auth_max_date"].string
        self.orderDescription = json["order_description"].string
        self.captureDescription = json["capture_description"].string
        self.updateDescription = json["update_description"].string
        self.cancelDescription = json["cancel_description"].string
        self.redirectUrl = json["redirect_url"].string
        self.redirectType = json["redirect_type"].string
        self.clientField1 = json["client_field_1"].string
        self.clientField2 = json["client_field_2"].string
        self.clientField3 = json["client_field_3"].string
        self.storeId = json["store_id"].string
        self.codeId = json["code_id"].string
        self.codeUrl = json["code_url"].string
        self.paymentId = json["payment_id"].string
        self.paypayResultCode = json["paypay_result_code"].string
        self.merchantPaymentId = json["merchant_payment_id"].string
        self.merchantCaptureId = json["merchant_capture_id"].string
        self.merchantUpdateId = json["merchant_update_id"].string
        self.merchantRevertId = json["merchant_revert_id"].string
        self.merchantRefundId = json["merchant_refund_id"].string
        self.paymentDate = json["payment_date"].string
        self.errorCode = json["error_code"].string
        self.created = json["created"].string
        self.updated = json["updated"].string
    }
}
