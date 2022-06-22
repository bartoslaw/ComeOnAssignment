//
//  WrapperWebView.swift
//  ComeOn Assignment
//
//  Created by Bartłomiej Smektała on 22/06/2022.
//

import Foundation
import WebKit

protocol WrapperWebViewDelegate {
    func onGameChosen(code: String)
}

final class WrapperWebView: WKWebView {
    private let toggleMessageHandlerKey = "toggleMessageHandler"
    private var delegate: WrapperWebViewDelegate?
    
    enum HandlerMessages: String {
        case gameChosen = "gameChosen"
    }
    
    override init(frame: CGRect, configuration: WKWebViewConfiguration) {
        super.init(frame: frame, configuration: configuration)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience required init(url: URL?, delegate: WrapperWebViewDelegate? = nil) {
        self.init()
        self.delegate = delegate
        
        if let url = url {
            let request = URLRequest(url: url)
            self.load(request)
        
            self.configuration.userContentController.add(self, name: self.toggleMessageHandlerKey)
        }
    }
}

extension WrapperWebView: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        guard
            let dictionary = message.body as? [String: AnyObject],
            let value = dictionary[HandlerMessages.gameChosen.rawValue] as? String
        else { return }
        
        self.delegate?.onGameChosen(code: value)
    }
}
