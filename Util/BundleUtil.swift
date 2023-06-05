//
//  BundleUtil.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/02/03.
//

import Foundation

class BundleUtil
{
    public let bundle: Bundle
    public static let instance = BundleUtil()
    
    private init(){
        bundle = Bundle(for: type(of: self))
    }
}
