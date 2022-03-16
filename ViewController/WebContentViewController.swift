//
//  WebContentViewController.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/03/08.
//

import UIKit
import WebKit

class WebContentViewController: UIViewController {

    @IBOutlet weak var wkWebView: WKWebView!
    
    var presenter: WebContentPresenterDelegate?
    var paymentResponse: FincodePaymentResponse?
    
    override func loadView() {
        wkWebView.navigationDelegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let res = paymentResponse,
              let acsUrl = res.acsUrl,
              let pareq = res.paReq,
              let accessId = res.accessId else { return }
        
        if let nsurl = URL(string: acsUrl) {
            logger("url = \(acsUrl)")
            var request = URLRequest(url: nsurl)
            request.httpMethod = "POST"
            request.httpBodyForForm([
                "PaReq": pareq,
                "MD": accessId
            ])
            
            self.wkWebView.load(request)
        }
    }
}

extension WebContentViewController: WKNavigationDelegate {

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction,
                 decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        logger("delegate called")
        if navigationAction.navigationType == .linkActivated {
            if let scheme = navigationAction.request.url?.scheme {
                if scheme == "tel" {
                    if UIApplication.shared.canOpenURL(navigationAction.request.url!) {
                        UIApplication.shared.openURL(navigationAction.request.url!)
                        decisionHandler(.cancel)
                        return
                    }
                }
            }
        }
        decisionHandler(.allow)
    }
}
