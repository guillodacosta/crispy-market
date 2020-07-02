//
//  SearchRobot.swift
//  crispy marketUITests
//
//  Created by guillermo on 6/29/20.
//  Copyright © 2020 guillodacosta. All rights reserved.
//

import XCTest

public class SearchRobot {
    
    private let app: XCUIApplication
    
    init(app: XCUIApplication) {
        self.app = app
    }
    
    @discardableResult
    func addQueryText() -> SearchRobot {
        let gKey = app.keys["celular"]
        gKey.tap()
        return self
    }
    
    @discardableResult
    func selectSearchBar() -> SearchRobot {
        XCUIApplication().children(matching: .searchField).firstMatch.tap()
        return self
    }
}

// MARK: Search view validations
extension SearchRobot {
    
    @discardableResult
    func checkIfSearchBarExists() -> SearchRobot {
        let searchFields = XCUIApplication().searchFields
        
        XCTAssert(searchFields.firstMatch.exists, "Doesn't exists searchfield")
        return self
    }
    
    @discardableResult
    func checkIfBringResults() -> SearchRobot {
        return self
    }
}
