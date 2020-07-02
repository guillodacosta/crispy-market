//
//  SearchViewControllerTests.swift
//  crispy marketUITests
//
//  Created by guillermo on 6/29/20.
//  Copyright © 2020 guillodacosta. All rights reserved.
//

import XCTest

class SearchViewControllerTests: XCTestCase {

    private let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    override class func setUp() {
        super.setUp()
        let app = XCUIApplication()
        
        app.launch()
    }
    
    func testSearchBarIsVisible() {
        let searchRobot = SearchRobot(app: app)
        
        searchRobot
            .checkIfSearchBarExists()
    }
    
    func testCanSearch() {
        let searchRobot = SearchRobot(app: app)
        
        searchRobot
            .selectSearchBar()
            .addQueryText()
            .checkIfBringResults()
    }
}
