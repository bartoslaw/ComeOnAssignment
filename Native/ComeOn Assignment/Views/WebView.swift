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
    var url: URL
    
    func makeUIView(context: Context) -> WrapperWebView {
        return WrapperWebView(url: self.url)
    }
    
    func updateUIView(_ webView: WrapperWebView, context: Context) {
    }
}
