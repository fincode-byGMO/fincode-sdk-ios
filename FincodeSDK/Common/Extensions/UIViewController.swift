//
//  UIViewController.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2021/12/24.
//

import UIKit

extension UIViewController {

    class var className: String {
        let classNameIncludeModuleName = NSStringFromClass(self)
        if let firstIndex = classNameIncludeModuleName.firstIndex(of: ".") {
            let startIndex = classNameIncludeModuleName.index(after: firstIndex)
            return String(classNameIncludeModuleName[startIndex...])
        } else {
            return ""
        }
    }

    @objc class var storyboardName: String {
        return className.replacingOccurrences(of: "Controller",
            with: "", options: .backwards, range: nil)
    }

    class var storyboardIdentifier: String {
        return className.replacingOccurrences(of: "Controller",
            with: "", options: .backwards, range: nil)
    }

    class func instantiateViewControllerFromStoryboard(_ bundle: Bundle? = nil,
        storyboardName: String? = nil,
        storyboardIdentifier: String? = nil)
        -> UIViewController?
    {
        let identifier: String! = storyboardIdentifier ?? self.storyboardIdentifier
        let name: String! = storyboardName ?? self.storyboardName
        let storyboard = UIStoryboard(name: name, bundle: bundle)
        return storyboard.instantiateViewController(withIdentifier: identifier)
    }
}
