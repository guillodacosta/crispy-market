//
//  SelectCountryRobot.swift
//  crispy marketUITests
//
//  Created by guillermo on 6/29/20.
//  Copyright © 2020 guillodacosta. All rights reserved.
//

import XCTest

public class SelectCountryRobot {
    
    private let app: XCUIApplication
    
    init(app: XCUIApplication) {
        self.app = app
    }
    
    @discardableResult
    func selectFirstItem() -> SelectCountryRobot {
        let availablecountrytableTable = XCUIApplication().tables["AvailableCountryTable"]
        availablecountrytableTable.staticTexts["Colombia"].waitForExistence(timeout: 10)
        availablecountrytableTable.staticTexts["Colombia"].tap()
        return self
    }
}

// MARK: Select Country validations
extension SelectCountryRobot {
    
    @discardableResult
    func checkIfLeaveView() -> SelectCountryRobot {
        let listCountryTable = XCUIApplication().tables["AvailableCountryTable"]
        
        XCTAssert(listCountryTable.exists, "Still is select country view")
        return self
    }
}
