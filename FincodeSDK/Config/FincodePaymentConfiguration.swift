//
//  FincodePaymentConfiguration.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/02/28.
//

import Foundation

@objc
public class FincodePaymentConfiguration: FincodeConfiguration {
    /// 決済種別
    @objc public var payType: String = ""
    
    /// 取引ID
    @objc public var accessId: String = ""
    
    /// オーダーID
    @objc public var id: String = ""
    
    /// 加盟店戻りURL
    @objc public var tds2RetUrl: String = ""
    
    /// 3DSリクエスター アカウント最終更新日
    @objc public var tds2ChAccChange: String = ""
    
    ///3DSリクエスター アカウント開設日
    @objc public var tds2ChAccDate: String = ""
    
    ///3DSリクエスター アカウントパスワード変更日
    @objc public var tds2ChAccPwChange: String = ""
    
    ///過去6ヶ月間の購入回数
    @objc public var tds2NbPurchaseAccount: String = ""
    
    ///カード登録日
    @objc public var tds2PaymentAccAge: String = ""
    
    ///過去24時間のカード追加の試行回数
    @objc public var tds2ProvisionAttemptsDay: String = ""
    
    ///出荷先住所の最初の使用日
    @objc public var tds2ShipAddressUsage: String = ""
    
    ///カード顧客名と出荷先名の一致/不一致情報
    @objc public var tds2ShipNameInd: String = ""
    
    ///アカウントの不審行為情報
    @objc public var tds2SuspiciousAccActivity: String = ""
    
    ///過去24時間の取引回数
    @objc public var tds2TxnActivityDay: String = ""
    
    ///前年の取引回数
    @objc public var tds2TxnActivityYear: String = ""
    
    ///ログイン証跡
    @objc public var tds2ThreeDsReqAuthData: String = ""
    
    ///ログイン方法
    @objc public var tds2ThreeDsReqAuthMethod: String = ""
    
    ///ログイン日時
    @objc public var tds2ThreeDsReqAuthTimestamp: String = ""
    
    ///請求先住所と配送先住所の一致/不一致情報
    @objc public var tds2AddrMatch: String = ""
    
    ///カード顧客の請求先住所の都市
    @objc public var tds2BillAddrCity: String = ""
    
    ///カード顧客の請求先住所の国コード
    @objc public var tds2BillAddrCountry: String = ""
    
    ///カード顧客の請求先住所の区域部分の１行目
    @objc public var tds2BillAddrLine1: String = ""
    
    ///カード顧客の請求先住所の区域部分の２行目
    @objc public var tds2BillAddrLine2: String = ""
    
    ///カード顧客の請求先住所の区域部分の３行目
    @objc public var tds2BillAddrLine3: String = ""
    
    ///カード顧客の請求先住所の郵便番号
    @objc public var tds2BillAddrPostCode: String = ""
    
    ///カード顧客の請求先住所の州または都道府県コード
    @objc public var tds2BillAddrState: String = ""
    
    ///カード顧客のメールアドレス
    @objc public var tds2Email: String = ""
    
    ///自宅電話の国コード
    @objc public var tds2HomePhoneCc: String = ""
    
    ///自宅電話番号
    @objc public var tds2HomePhoneNo: String = ""
    
    ///携帯電話の国コード
    @objc public var tds2MobilePhoneCc: String = ""
    
    ///携帯電話番号
    @objc public var tds2MobilePhoneNo: String = ""
    
    ///職場電話の国コード
    @objc public var tds2WorkPhoneCc: String = ""
    
    ///職場電話番号
    @objc public var tds2WorkPhoneNo: String = ""
    
    ///出荷先住所の都市
    @objc public var tds2ShipAddrCity: String = ""
    
    ///出荷先住所の国コード
    @objc public var tds2ShipAddrCountry: String = ""
    
    ///出荷先住所の区域部分の１行目
    @objc public var tds2ShipAddrLine1: String = ""
    
    ///出荷先住所の区域部分の２行目
    @objc public var tds2ShipAddrLine2: String = ""
    
    ///出荷先住所の区域部分の３行目
    @objc public var tds2ShipAddrLine3: String = ""
    
    ///出荷先住所の郵便番号
    @objc public var tds2ShipAddrPostCode: String = ""
    
    ///出荷先住所の州または都道府県コード
    @objc public var tds2ShipAddrState: String = ""
    
    ///納品先電子メールアドレス
    @objc public var tds2DeliveryEmailAddress: String = ""
    
    ///商品納品時間枠
    @objc public var tds2DeliveryTimeframe: String = ""
    
    ///プリペイドカードまたはギフトカードの総購入金額
    @objc public var tds2GiftCardAmount: String = ""
    
    ///購入されたプリペイドカードまたはギフトカード / コードの総数
    @objc public var tds2GiftCardCount: String = ""
    
    ///通貨コード
    @objc public var tds2GiftCardCurr: String = ""
    
    ///商品の発売予定日
    @objc public var tds2PreOrderDate: String = ""
    
    ///商品の販売時期情報
    @objc public var tds2PreOrderPurchaseInd: String = ""
    
    ///商品の注文情報
    @objc public var tds2ReorderItemsInd: String = ""
    
    ///取引の出荷方法
    @objc public var tds2ShipInd: String = ""
    
    ///継続課金の期限
    @objc public var tds2RecurringExpiry: String = ""
    
    ///継続課金の課金最小間隔日数
    @objc public var tds2RecurringFrequency: String = ""
    
    override public init() {
        super.init()
        self.useCase = .payment
    }
}
