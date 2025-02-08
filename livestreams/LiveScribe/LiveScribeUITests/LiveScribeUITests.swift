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
    
    func testOutputMatchesInput() {
        _ = app.webViews.firstMatch.waitForExistence(timeout: 1)
        _ = app.textViews.firstMatch.waitForExistence(timeout: 1)
        let targetText = UUID().uuidString
        app.textViews.firstMatch.tap()
        app.typeText("Hello, world")
        XCTAssertTrue(app.webViews.firstMatch.staticTexts[targetText].exists, "Typing into the editor should create matching output.")
    }

}
