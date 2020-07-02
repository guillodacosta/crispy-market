//
//  CountriesViewControllerTests.swift
//  crispy marketUITests
//
//  Created by guillermo on 6/29/20.
//  Copyright © 2020 guillodacosta. All rights reserved.
//

import XCTest

class CountriesViewControllerTests: XCTestCase {

    private let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = true
    }
    
    override class func setUp() {
        super.setUp()
        let app = XCUIApplication()
        
        app.launch()
    }
    
    func testShowCountrieList() {
        let countrySelectRobot = SelectCountryRobot(app: app)
        
        countrySelectRobot
            .selectFirstItem()
            .checkIfLeaveView()
    }
}

