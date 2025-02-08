//
//  LiveScribeUITests.swift
//  LiveScribeUITests
//
//  Created by James Clarke on 2/8/25.
//

import XCTest

@MainActor
final class LiveScribeUITests: XCTestCase {
    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }
    
    func testInputExists() {
        XCTAssertEqual(app.textViews.count, 1, "There should be one text editor for users to type into.")
    }
    
    func testOutputExists() {
        let webViewExists = app.webViews.firstMatch.waitForExistence(timeout: 1)
        XCTAssertTrue(webViewExists, "there should be a webview")
    }

}
