//
//  ContentVCExtension.swift
//  GoogleNewsMVVM
//
//  Created by Mr. T. on 2.03.2020.
//  Copyright © 2020 Mr. T. All rights reserved.
//

import Foundation
import UIKit
import WebKit

extension ContentViewController : WKNavigationDelegate{
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.isHidden = true
        activityIndicator.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
}
