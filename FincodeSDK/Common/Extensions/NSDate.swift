//
//  NSDate.swift
//  fincode-ios
//
//  Created by 中嶋彰 on 2021/12/15.
//  Copyright © 2021年 GMO Payment Gateway, Inc. All rights reserved.
//

import UIKit

extension Date {

    // MARK: Instance Methods

    fileprivate static func getFormatter() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        dateFormatter.locale = Locale(identifier: "ja_jp")
        return dateFormatter
    }

    func stringHyphenateYYYYMMDD() -> String {
        let dateFormat = type(of: self).getFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd"
        return dateFormat.string(from: self)
    }

    func stringSlashedYYYYMMDDHHMM() -> String {
        let dateFormat = type(of: self).getFormatter()
        dateFormat.dateFormat = "yyyy/MM/dd HH:mm"
        return dateFormat.string(from: self)
    }

    func stringSlashedYYYYMMDD() -> String {
        let dateFormat = type(of: self).getFormatter()
        dateFormat.dateFormat = "yyyy/MM/dd"
        return dateFormat.string(from: self)
    }

    func stringSlashedYYYYMM() -> String {
        let dateFormat = type(of: self).getFormatter()
        dateFormat.dateFormat = "yyyy/MM"
        return dateFormat.string(from: self)
    }

    func stringSlashedYYYYMMDDHHMMSS() -> String {
        return stringByFormat("yyyy/MM/dd HH:mm:ss")
    }

    func stringHyphenateYYYYMMDDHHMMSSSSSZZZZZ() -> String {
        let dateFormat = type(of: self).getFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        return dateFormat.string(from: self)
    }

    func stringDate() -> String {
        return stringByFormat("yyyy.MM.dd")
    }

    func stringDateTime() -> String {
        return stringByFormat("yyyy.MM.dd HH:mm")
    }

    func stringSlashedDateTime() -> String {
        return stringByFormat("yyyy/MM/dd HH:mm")
    }

    func stringMonthAndDay() -> String {
        return stringByFormat("MM.dd")
    }

    func stringTime() -> String {
        return stringByFormat("HH:mm")
    }

    func stringTimestamp() -> String {
        return stringByFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ")
    }

    func stringTimestampJapan() -> String {
        return stringByFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ", isJapan: true)
    }

    func stringHyphenateDate() -> String {
        return stringByFormat("yyyy-MM-dd")
    }

    func stringHyphenateMonthAndDay() -> String {
        return stringByFormat("MM-dd")
    }

    func stringLocalizedDateTime() -> String {
        return stringByFormat("yyyy年MM月dd日 HH:mm")
    }

    func stringLocalizedDateTimeKanji() -> String {
        return stringByFormat("yyyy年MM月dd日HH時mm分")
    }

    func stringLocalizedMonthAndDay() -> String {
        return stringByFormat("MM月 dd日")
    }

    func stringLocalizedDate() -> String {
        return stringByFormat("yyyy年MM月dd日")
    }

    func stringLocalizedDateAndWeekday() -> String {
        return stringByFormat("yyyy年MM月dd日(E)")
    }

    func stringByFormat(_ string: String, isJapan: Bool = false) -> String {

        let formatter = type(of: self).getFormatter()
        //サーバーへの要求に影響すると困るので固定のlocaleを利用する
        formatter.locale = Locale(identifier : "ja_JP")
        //let locale = NSLocale.currentLocale()
        //if let format = NSDateFormatter.dateFormatFromTemplate
        //(string, options: 0, locale: locale) {
        formatter.dateFormat = string
        if isJapan {
            formatter.timeZone = TimeZone(identifier: "Asia/Tokyo")
        }
        let stringDate =  formatter.string(from: self)
        //("stringByFormat: format:\(string) value:\(stringDate)")
        return stringDate
        //}
        //return self.description
    }

    // MARK: Class Methods

    static func parseDate(_ value: String) -> Date {
        if value.isEmpty { return Date() }
        let dateFormat = self.getFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd"
        if let v = dateFormat.date(from: value) {
            return v
        } else {
            logger("Failed to parse Date string with \"\(value)\"")
            return Date()
        }
    }

    static func parseDate(optional value: String?) -> Date? {
        if let v = value, !v.isEmpty {
            return parseDate(v)
        }
        return nil
    }

    static func parseYYYYMMDDHHMM(_ value: String) -> Date {
        if value.isEmpty { return Date() }
        let dateFormat = self.getFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd HH:mm"
        if let date = dateFormat.date(from: value) {
            return date
        } else {
            logger("Failed to parse YYYYMMDDHHMM string with \"\(value)\"")
            return Date()
        }
    }

    static func parseYYYYMMDDHHMM(optional value: String?) -> Date? {
        if let v = value, !v.isEmpty {
            return parseYYYYMMDDHHMM(v)
        }
        return nil
    }

    static func parseDateTime(_ value: String) -> Date {
        if value.isEmpty { return Date() }
        let dateFormat = self.getFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SZZZZZ"
        if let date = dateFormat.date(from: value) {
            return date
        } else {
            logger("Failed to parse DateTime string with \"\(value)\"")
            return Date()
        }
    }

    static func parseDateTime(optional value: String?) -> Date? {
        if let v = value, !v.isEmpty {
            return parseDateTime(v)
        }
        return nil
    }

    static func parseTime(_ value: String) -> Date {
        if value.isEmpty { return Date() }
        let dateFormat = self.getFormatter()
        dateFormat.dateFormat = "HH:mm"
        if let v = dateFormat.date(from: value) {
            return v
        } else {
            logger("Failed to parse Time string with \"\(value)\"")
            return Date()
        }
    }

    static func parseTime(optional value: String?) -> Date? {
        if let v = value, !v.isEmpty {
            return parseTime(v)
        }
        return nil
    }

}
