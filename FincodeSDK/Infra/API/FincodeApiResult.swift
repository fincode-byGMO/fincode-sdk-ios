//
//  FincodeApiResult.swift
//  fincode-ios
//
//  Created by 中嶋彰 on 2021/12/15.
//  Copyright © 2021年 GMO Payment Gateway, Inc. All rights reserved.
//

import UIKit

public enum FincodeApiResult<T> {
    case success(T)
    case failure(FincodeAPIError)

    init(_ value: T) {
        self = .success(value)
    }

    init(_ error: FincodeAPIError) {
        self = .failure(error)
    }
}
