//
//  WebView.swift
//  ComeOn Assignment
//
//  Created by Bartłomiej Smektała on 22/06/2022.
//

import Foundation
import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    var url: URL?
    var completionHandler: (String) -> ()
    
    func makeUIView(context: Context) -> WrapperWebView {
        let wrapperWebView = WrapperWebView(url: self.url, delegate: self)
        return wrapperWebView
    }
    
    func updateUIView(_ webView: WrapperWebView, context: Context) {
    }
}

extension WebView: WrapperWebViewDelegate {
    func onGameChosen(code: String) {
        self.completionHandler(code)
    }
}
