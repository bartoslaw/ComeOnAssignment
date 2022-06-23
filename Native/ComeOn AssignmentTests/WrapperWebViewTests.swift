//
//  WrapperWebViewTests.swift
//  ComeOn AssignmentTests
//
//  Created by Bartłomiej Smektała on 23/06/2022.
//

import XCTest
import Combine
import WebKit

@testable import ComeOn_Assignment

class WrapperWebViewTests: XCTestCase {
    let javascriptToEvaluate = """
            window.webkit.messageHandlers.toggleMessageHandler.postMessage({gameChosen: "jackhammer"});
    """
    
    var wrapperWebView: WrapperWebView?
    
    override func setUpWithError() throws {
        self.wrapperWebView = WrapperWebView(url: nil, delegate: nil)
    }
    
    func testInitialStateCorrect() throws {
        let expectation = XCTestExpectation(description: "Check if java scrip handler works correctly")
        
        self.wrapperWebView?.evaluateJavaScript(javascriptToEvaluate, completionHandler: { res, error in
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 10.0)
        
        XCTAssert(self.wrapperWebView?.lastBrowserRequest?.message == .gameChosen)
        XCTAssert(self.wrapperWebView?.lastBrowserRequest?.value as? String == "jackhammer")
    }
}

