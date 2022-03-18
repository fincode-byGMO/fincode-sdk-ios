//
//  WebContentViewController.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/03/08.
//

import UIKit
import WebKit

protocol WebContentViewDelegate: AnyObject {
    func tdsComplete(_ result: [String:String])
}

class WebContentViewController: UIViewController {

    @IBOutlet weak var wkWebView: WKWebView!
    
    var presenter: WebContentPresenterDelegate?
    var paymentResponse: FincodePaymentResponse?
    var delegate: WebContentViewDelegate?
    
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
            request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.setHttpBodyForForm([
                "PaReq": pareq.urlEncoded,
                "MD": accessId,
                "TermUrl": "https://webhook.site/cd6e0969-2e65-46a7-87ec-d1a3f18cf073" // TODO: 加盟店側からもらう情報として実装する
            ])
            
            wkWebView.navigationDelegate = self
            wkWebView.load(request)
        }
    }
}

extension WebContentViewController: WKNavigationDelegate {
    
    private func isTermUrl(_ url: URL?) -> Bool {
        if let u = url, u.absoluteString == "https://webhook.site/cd6e0969-2e65-46a7-87ec-d1a3f18cf073" {  // TODO: 加盟店側からもらう情報として実装する
            return true
        }
        return false
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction,
                 decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        if isTermUrl(navigationAction.request.url) {
            decisionHandler(.allow)
            self.navigationController?.popViewController(animated: true)
            
            var request = navigationAction.request
            if let body = request.getHttpBodyForForm() {
                delegate?.tdsComplete(body)
            }
            
            return
        }
        
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
    
    func webView(_ webView: WKWebView,
                 decidePolicyFor navigationResponse: WKNavigationResponse,
                 decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {

        decisionHandler(.allow)
    }
}
