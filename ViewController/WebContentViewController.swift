//
//  WebContentViewController.swift
//  FincodeSDK
//
//  Created by 中嶋彰 on 2022/03/08.
//

//import Foundation
import UIKit
import WebKit

protocol WebContentViewDelegate: AnyObject {
    func changePage(_ url: String)
    func showIndicator()
    func hideIndicator()
}

class WebContentViewController: UIViewController {

    @IBOutlet weak var webViewContainer: UIView!
    @IBOutlet weak var indicatorView: UIView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    var presenter: WebContentPresenterDelegate?
    var config: FincodePaymentConfiguration?
    var url: String?
    var loadUrl: LoadUrl = .NONE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideIndicator()
        
        guard let url = url else { return }
        addWebView(url)
    }
    
    private func addWebView(_ url: String) {
        
        if let nsurl = URL(string: url) {
            logger("load url = \(url)", function: "webview")
            
            var urlRequest = URLRequest(url: nsurl)
            urlRequest.httpMethod = "GET"
            
            let webview = WKWebView()
            webview.navigationDelegate = self
            webview.load(urlRequest)
            
            webViewContainer.addSubview(webview)
            webview.anchorAll(equalTo: webViewContainer)
            webview.sizeToFit()
        }
    }
    
    private func removeWebView() {
        webViewContainer.removeAllSubviews()
    }
    
    private func isTds2RetUrl(_ url: URL?) -> Bool {
        
        guard let config = config, let u = url, let scheme = u.scheme, let host = u.host else { return false }
        
        if let configTds2RetUrl = URL(string: config.tds2RetUrl), scheme == configTds2RetUrl.scheme, host == configTds2RetUrl.host {
            return true
        } else {
            return false
        }
    }
    
    private func isRedirectChallengeUrl(_ navigationAction: WKNavigationAction) -> Bool {
        if let config = config, let u = navigationAction.request.url, u.absoluteString.hasPrefix(config.tds2RetUrl) {
            return true
        }
        return false
    }
}

// MARK: - WKNavigationDelegate

extension WebContentViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction,
                 decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        var request = navigationAction.request
        
        logger("\n■■■ webview action request ■■■",
               "URL: \(request.url)",
               "METHOD: \(request.httpMethod)",
               "QUERY: \(request.getQuery())",
               "BODY: \(request.getHttpBodyForForm())", "\n",
               function: "webview")
        
        if loadUrl == .TDS2_ACS_URL, isTds2RetUrl(request.url), let data = request.getHttpBodyForForm(), let query = request.getQuery() {
            presenter?.tds2RetUrlReqHandler(body: data, query: query)
        }
        
//        if navigationAction.navigationType == .linkActivated {
//            if let scheme = navigationAction.request.url?.scheme {
//                if scheme == "tel" {
//                    if UIApplication.shared.canOpenURL(navigationAction.request.url!) {
//                        UIApplication.shared.openURL(navigationAction.request.url!)
//                        decisionHandler(.cancel)
//                        return
//                    }
//                }
//            }
//        }
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView,
                 decidePolicyFor navigationResponse: WKNavigationResponse,
                 decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {

        decisionHandler(.allow)
    }
}

// MARK: - notify presenter event to view

extension WebContentViewController: WebContentViewDelegate {
    
    func changePage(_ url: String) {
        // clear webview for current page
        removeWebView()
        // add webview for new page
        addWebView(url)
    }
    
    func showIndicator() {
        indicatorView.isHidden = false
        indicator.startAnimating()
    }
    
    func hideIndicator() {
        indicatorView.isHidden = true
        indicator.stopAnimating()
    }
}
