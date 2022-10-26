//
//  Tds2Event.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/10/15.
//

import Foundation

enum Tds2Event: String {
    case NONE = ""
    case TDS_METHOD_FINISHED = "3DSMethodFinished"
    case TDS_METHOD_SKIPPED = "3DSMethodSkipped"
    case AUTH_RESULT_READY = "AuthResultReady"
}
