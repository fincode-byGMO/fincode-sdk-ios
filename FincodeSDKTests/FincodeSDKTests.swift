//
//  FincodeSDKTests.swift
//  FincodeSDKTests
//
//  Created by 中嶋彰 on 2022/01/11.
//

import XCTest
@testable import FincodeSDK

class FincodeSDKTests: XCTestCase {

    // テスト用のセットアップコードを記載(各テスト関数実行前に実行されます)
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    // テスト用の終了コードを記載(各テスト関数実行後に実行されます)
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPaymentExample() throws {
        
//        let paymentInteractor = PaymentInteractor()
//        let param = PaymentRequest(sample: "")
//        try paymentInteractor.payment(param, header: SettingUseCase.sharedInstance.requestHeader)
        
        var config = FCConfiguration()
        config.apiVersion = "ver20211231"
        config.authorizationMethod = .Bearer(apiKey: "teXGfdg")
        
        let view = FCPaymentVerticalView()
        view.setConfiguration(config)
        //try view.touchPaymentButton("")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
