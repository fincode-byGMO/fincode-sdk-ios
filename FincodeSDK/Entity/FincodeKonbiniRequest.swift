//
//  FincodeKonbiniRequest.swift
//  FincodeSDK
//
//  Created by m.ito on 2023/07/28.
//

import Foundation

public class FincodeKonbiniRequest {
    
    public var payType: String?
    public var accessId: String?
    public var id: String?
    public var customerId: String?
    public var paymentTermDay: String?
    public var deviceName: String?
    public var winWidth: String?
    public var winHeight: String?
    public var pixelRatio: String?
    public var winSizeType: String?
    
    public init() {
    }
    
    func parameters() -> [String: AnyObject] {
        var data: [String: AnyObject] = [:]
        setParam(&data, key: "pay_type", param: payType)
        setParam(&data, key: "access_id", param: accessId)
        setParam(&data, key: "id", param: id)
        setParam(&data, key: "customer_id", param: customerId)
        setParam(&data, key: "payment_term_day", param: paymentTermDay)
        setParam(&data, key: "device_name", param: deviceName)
        setParam(&data, key: "win_width", param: winWidth)
        setParam(&data, key: "win_height", param: winHeight)
        setParam(&data, key: "pixel_ratio", param: pixelRatio)
        setParam(&data, key: "win_size_type", param: winSizeType)
        
        return data
    }
    
    private func setParam(_ data: inout [String: AnyObject], key: String, param: Any?) {
        if let p = param {
            data[key] = p as AnyObject
        }
    }
}

public class FincodeKonbiniResponse: FincodeResponse {

    public let shopId: String?
    public let id: String?
    public let payType: String?
    public let status: String?
    public let accessId: String?
    public let processDate: String?
    public let amount: Int64?
    public let tax: Int64?
    public let totalAmount: Int64?
    public let paymentTermDay: String?
    public let paymentTerm: String?
    public let deviceName: String?
    public let osVersion: String?
    public let winWidth: String?
    public let winHeight: String?
    public let xdpi: String?
    public let ydpi: String?
    public let clientField1: String?
    public let clientField2: String?
    public let clientField3: String?
    public let result: String?
    public let orderSerial: String?
    public let invoiceId: String?
    public let barcode: String?
    public let barcodeFormat: String?
    public let barcodeWidth: String?
    public let barcodeHeight: String?
    public let paymentDate: String?
    public let konbiniCode: String?
    public let konbiniStoreCode: String?
    public let errorCode: String?
    public let overpaymentFlag: String?
    public let cancelOverpaymentFlag: String?
    public let created: String?
    public let updated: String?
    
    init(json: JSON) {
        self.shopId = json["shop_id"].string
        self.id = json["id"].string
        self.payType = json["pay_type"].string
        self.status = json["status"].string
        self.accessId = json["access_id"].string
        self.processDate = json["process_date"].string
        self.amount = json["amount"].int64
        self.tax = json["tax"].int64
        self.totalAmount = json["total_amount"].int64
        self.paymentTermDay = json["payment_term_day"].string
        self.paymentTerm = json["payment_term"].string
        self.deviceName = json["device_name"].string
        self.osVersion = json["os_version"].string
        self.winWidth = json["win_width"].string
        self.winHeight = json["win_height"].string
        self.xdpi = json["xdpi"].string
        self.ydpi = json["ydpi"].string
        self.clientField1 = json["client_field_1"].string
        self.clientField2 = json["client_field_2"].string
        self.clientField3 = json["client_field_3"].string
        self.result = json["result"].string
        self.orderSerial = json["order_serial"].string
        self.invoiceId = json["invoice_id"].string
        self.barcode = json["barcode"].string
        self.barcodeFormat = json["barcode_format"].string
        self.barcodeWidth = json["barcode_width"].string
        self.barcodeHeight = json["barcode_height"].string
        self.paymentDate = json["payment_date"].string
        self.konbiniCode = json["konbini_code"].string
        self.konbiniStoreCode = json["konbini_store_code"].string
        self.errorCode = json["error_code"].string
        self.overpaymentFlag = json["overpayment_flag"].string
        self.cancelOverpaymentFlag = json["cancel_overpayment_flag"].string
        self.created = json["created"].string
        self.updated = json["updated"].string
    }
}
