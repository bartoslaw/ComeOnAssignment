//
//  WrapperWebView.swift
//  ComeOn Assignment
//
//  Created by Bartłomiej Smektała on 22/06/2022.
//

import Foundation
import WebKit

final class WrapperWebView: WKWebView {
    private let toggleMessageHandlerKey = "toggleMessageHandler"
    
    enum HandlerMessages: String {
        case gameChosen = "gameChosen"
    }
    
    override init(frame: CGRect, configuration: WKWebViewConfiguration) {
        super.init(frame: frame, configuration: configuration)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience required init(url: URL) {
        self.init()
                
        let request = URLRequest(url: url)
        self.load(request)
    
        self.configuration.userContentController.add(self, name: self.toggleMessageHandlerKey)
    }
}

extension WrapperWebView: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        guard let dictionary = message.body as? [String: AnyObject] else { return }

        print(dictionary)
    }
}
