//
//  WebContentViewController.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/03/08.
//

import UIKit
import WebKit

protocol WebContentViewDelegate: AnyObject {
    func tdsComplete(_ paRes: String?)
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
            request.httpBodyForForm([
                "PaReq": pareq,
                "MD": accessId
            ])
            
            wkWebView.navigationDelegate = self
            wkWebView.load(request)
        }
    }
}

extension WebContentViewController: WKNavigationDelegate {

    #if DEBUG
    // 読み込み開始時イベント
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("start")
    }

    // 読み込み終了時イベント
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("finish")
    }

    // 読み込み失敗時イベント
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("fail")
    }
    #endif
    
    private func isTermUrl(_ url: URL?) -> Bool {
        if let u = url, let host = u.host, let sendUrl = paymentResponse?.sendUrl {
            if host == sendUrl {
                return true
            }
        }
        return false
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction,
                 decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        if isTermUrl(navigationAction.request.url) {
            decisionHandler(.allow)
            self.dismiss(animated: true)
            delegate?.tdsComplete("paRes")
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
