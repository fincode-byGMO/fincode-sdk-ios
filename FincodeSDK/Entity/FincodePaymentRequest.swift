//
//  FincodePaymentRequest.swift
//  fincode-ios
//
//  Created by 中嶋彰 on 2021/12/06.
//  Copyright © 2021年 GMO Payment Gateway, Inc. All rights reserved.
//

import Foundation

public class FincodePaymentRequest {
    
    public var payType: String?
    public var accessId: String?
    public var id: String?
    public var token: String?
    public var cardNo: String?
    public var expire: String?
    public var customerId: String?
    public var cardId: String?
    public var method: String?
    public var payTimes: String?
    public var securityCode: String?
    public var holderName: String?
    public var tds2RetUrl: String?
    public var tds2ChAccChange: String?
    public var tds2ChAccDate: String?
    public var tds2ChAccPwChange: String?
    public var tds2NbPurchaseAccount: String?
    public var tds2PaymentAccAge: String?
    public var tds2ProvisionAttemptsDay: String?
    public var tds2ShipAddressUsage: String?
    public var tds2ShipNameInd: String?
    public var tds2SuspiciousAccActivity: String?
    public var tds2TxnActivityDay: String?
    public var tds2TxnActivityYear: String?
    public var tds2ThreeDsReqAuthData: String?
    public var tds2ThreeDsReqAuthMethod: String?
    public var tds2ThreeDsReqAuthTimestamp: String?
    public var tds2AddrMatch: String?
    public var tds2BillAddrCity: String?
    public var tds2BillAddrCountry: String?
    public var tds2BillAddrLine1: String?
    public var tds2BillAddrLine2: String?
    public var tds2BillAddrLine3: String?
    public var tds2BillAddrPostCode: String?
    public var tds2BillAddrState: String?
    public var tds2Email: String?
    public var tds2HomePhoneCc: String?
    public var tds2HomePhoneNo: String?
    public var tds2MobilePhoneCc: String?
    public var tds2MobilePhoneNo: String?
    public var tds2WorkPhoneCc: String?
    public var tds2WorkPhoneNo: String?
    public var tds2ShipAddrCity: String?
    public var tds2ShipAddrCountry: String?
    public var tds2ShipAddrLine1: String?
    public var tds2ShipAddrLine2: String?
    public var tds2ShipAddrLine3: String?
    public var tds2ShipAddrPostCode: String?
    public var tds2ShipAddrState: String?
    public var tds2DeliveryEmailAddress: String?
    public var tds2DeliveryTimeframe: String?
    public var tds2GiftCardAmount: String?
    public var tds2GiftCardCount: String?
    public var tds2GiftCardCurr: String?
    public var tds2PreOrderDate: String?
    public var tds2PreOrderPurchaseInd: String?
    public var tds2ReorderItemsInd: String?
    public var tds2ShipInd: String?
    public var tds2RecurringExpiry: String?
    public var tds2RecurringFrequency: String?
    
    public init() {
    }
    
    func parameters() -> [String: AnyObject] {
        var data: [String: AnyObject] = [:]
        setParam(&data, key: "pay_type", param: payType)
        setParam(&data, key: "access_id", param: accessId)
        setParam(&data, key: "id", param: id)
        setParam(&data, key: "token", param: token)
        setParam(&data, key: "card_no", param: cardNo)
        setParam(&data, key: "expire", param: expire)
        setParam(&data, key: "customer_id", param: customerId)
        setParam(&data, key: "card_id", param: cardId)
        setParam(&data, key: "method", param: method)
        setParam(&data, key: "pay_times", param: payTimes)
        setParam(&data, key: "security_code", param: securityCode)
        setParam(&data, key: "holder_name", param: holderName)
        setParam(&data, key: "tds2_ret_url", param: tds2RetUrl)
        setParam(&data, key: "tds2_ch_acc_change", param: tds2ChAccChange)
        setParam(&data, key: "tds2_ch_acc_date", param: tds2ChAccDate)
        setParam(&data, key: "tds2_ch_acc_pw_change", param: tds2ChAccPwChange)
        setParam(&data, key: "tds2_nb_purchase_account", param: tds2NbPurchaseAccount)
        setParam(&data, key: "tds2_payment_acc_age", param: tds2PaymentAccAge)
        setParam(&data, key: "tds2_provision_attempts_day", param: tds2ProvisionAttemptsDay)
        setParam(&data, key: "tds2_ship_address_usage", param: tds2ShipAddressUsage)
        setParam(&data, key: "tds2_ship_name_ind", param: tds2ShipNameInd)
        setParam(&data, key: "tds2_suspicious_acc_activity", param: tds2SuspiciousAccActivity)
        setParam(&data, key: "tds2_txn_activity_day", param: tds2TxnActivityDay)
        setParam(&data, key: "tds2_txn_activity_year", param: tds2TxnActivityYear)
        setParam(&data, key: "tds2_three_ds_req_auth_data", param: tds2ThreeDsReqAuthData)
        setParam(&data, key: "tds2_three_ds_req_auth_method", param: tds2ThreeDsReqAuthMethod)
        setParam(&data, key: "tds2_three_ds_req_auth_timestamp", param: tds2ThreeDsReqAuthTimestamp)
        setParam(&data, key: "tds2_addr_match", param: tds2AddrMatch)
        setParam(&data, key: "tds2_bill_addr_city", param: tds2BillAddrCity)
        setParam(&data, key: "tds2_bill_addr_country", param: tds2BillAddrCountry)
        setParam(&data, key: "tds2_bill_addr_line_1", param: tds2BillAddrLine1)
        setParam(&data, key: "tds2_bill_addr_line_2", param: tds2BillAddrLine2)
        setParam(&data, key: "tds2_bill_addr_line_3", param: tds2BillAddrLine3)
        setParam(&data, key: "tds2_bill_addr_post_code", param: tds2BillAddrPostCode)
        setParam(&data, key: "tds2_bill_addr_state", param: tds2BillAddrState)
        setParam(&data, key: "tds2_email", param: tds2Email)
        setParam(&data, key: "tds2_home_phone_cc", param: tds2HomePhoneCc)
        setParam(&data, key: "tds2_home_phone_no", param: tds2HomePhoneNo)
        setParam(&data, key: "tds2_mobile_phone_cc", param: tds2MobilePhoneCc)
        setParam(&data, key: "tds2_mobile_phone_no", param: tds2MobilePhoneNo)
        setParam(&data, key: "tds2_work_phone_cc", param: tds2WorkPhoneCc)
        setParam(&data, key: "tds2_work_phone_no", param: tds2WorkPhoneNo)
        setParam(&data, key: "tds2_ship_addr_city", param: tds2ShipAddrCity)
        setParam(&data, key: "tds2_ship_addr_country", param: tds2ShipAddrCountry)
        setParam(&data, key: "tds2_ship_addr_line_1", param: tds2ShipAddrLine1)
        setParam(&data, key: "tds2_ship_addr_line_2", param: tds2ShipAddrLine2)
        setParam(&data, key: "tds2_ship_addr_line_3", param: tds2ShipAddrLine3)
        setParam(&data, key: "tds2_ship_addr_post_code", param: tds2ShipAddrPostCode)
        setParam(&data, key: "tds2_ship_addr_state", param: tds2ShipAddrState)
        setParam(&data, key: "tds2_delivery_email_address", param: tds2DeliveryEmailAddress)
        setParam(&data, key: "tds2_delivery_timeframe", param: tds2DeliveryTimeframe)
        setParam(&data, key: "tds2_gift_card_amount", param: tds2GiftCardAmount)
        setParam(&data, key: "tds2_gift_card_count", param: tds2GiftCardCount)
        setParam(&data, key: "tds2_gift_card_curr", param: tds2GiftCardCurr)
        setParam(&data, key: "tds2_pre_order_date", param: tds2PreOrderDate)
        setParam(&data, key: "tds2_pre_order_purchase_ind", param: tds2PreOrderPurchaseInd)
        setParam(&data, key: "tds2_reorder_items_ind", param: tds2ReorderItemsInd)
        setParam(&data, key: "tds2_ship_ind", param: tds2ShipInd)
        setParam(&data, key: "tds2_recurring_expiry", param: tds2RecurringExpiry)
        setParam(&data, key: "tds2_recurring_frequency", param: tds2RecurringFrequency)
        return data
    }
    
    private func setParam(_ data: inout [String: AnyObject], key: String, param: Any?) {
        if let p = param {
            data[key] = p as AnyObject
        }
    }
}

public class FincodePaymentResponse: FincodeResponse {

    public let acs: String?
    public let shopId: String?
    public let id: String?
    public let payType: String?
    public let status: String?
    public let accessId: String?
    public let processDate: Date?
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
    public let authMaxDate: Date?
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
    public let acsUrl: String?
    public let paReq: String?
    public let created: Date?
    public let updated: Date?
    
    init(json: JSON) {
        self.acs = json["acs"].string
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
        self.acsUrl = json["acs_url"].string
        self.paReq = json["pa_req"].string
        self.created = json["created"].date
        self.updated = json["updated"].date
    }
}
