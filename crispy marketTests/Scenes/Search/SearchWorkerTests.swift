//
//  SearchWorkerTests.swift
//  crispy marketTests
//
//  Created by guillermo on 7/5/20.
//  Copyright © 2020 guillodacosta. All rights reserved.
//

import XCTest
import Foundation
@testable import crispy_market

class SearchWorkerTests: XCTestCase {
    // MARK: Subject under test
    
    var sut: SearchWorker!
    
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        setupOrdersWorker()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupOrdersWorker() {
        let apiLogSpy = MarketLogApiSpy()
        sut = SearchWorker(store: MarketApiSpy(apiLog: apiLogSpy))
    }
    
    // MARK: Test doubles
    
    class MarketLogApiSpy: MarketLogAPI {}
    
    class MarketApiSpy: MarketAPI {
        // MARK: Method call expectations
        
        var fetchedItemsCalled = false
        var fetchSearchError: SearchError?
        var fetchItemsResponse: Items.FetchItems.Response?
        
        // MARK: Spied methods
        
        override func fetchItems(request: Items.FetchItems.Request, completionHandler: @escaping (_ response: Items.FetchItems.Response?, SearchError?) -> Void) {
            fetchedItemsCalled = true
            let oneSecond = DispatchTime.now() + .seconds(1)
            DispatchQueue.main.asyncAfter(deadline: oneSecond) {
                if let searchError = self.fetchSearchError {
                    completionHandler(nil, searchError)
                } else {
                    completionHandler(self.fetchItemsResponse, nil)
                }
            }
        }
    }
    
    // MARK: Tests
    
    func testFetchItemsShouldReturnListOfItems() {
        // Given
        guard let marketApiStoreSpy = sut.store as? MarketApiSpy else {
            XCTAssert(false)
            return
        }
        let itemsViewModelResponse = [Items.FetchItems.ViewModel(id: "", siteID: "MCO", title: "", seller: nil, price: 40.0, currencyID: "COP", availableQuantity: 10, soldQuantity: 0, buyingMode: "", listingTypeID: "", stopTime: "", condition: "new", permalink: "", thumbnail: "", acceptsMercadopago: true, installments: nil, address: nil, shipping: nil, sellerAddress: nil, attributes: nil, originalPrice: 40.0, categoryID: "", tags: [])]
        let request = Items.FetchItems.Request(countryID: "MCO", query: "celular")
        var responseSUT: Items.FetchItems.Response?
        
        marketApiStoreSpy.fetchItemsResponse = Items.FetchItems.Response(paging: Items.Paging(total: 50, offset: 1, limit: 50, primaryResults: 50), results: itemsViewModelResponse, siteID: "MCO")
        
        // When
        let expectation = XCTestExpectation(description: "Wait for fetched items result")
        sut.fetchItems(request: request) { (response, error) -> Void in
            responseSUT = response
            expectation.fulfill()
        }
        
        // Then
        XCTAssert(marketApiStoreSpy.fetchedItemsCalled, "Calling fetchItems() should ask the data store for a list of items")
        wait(for: [expectation], timeout: 2)
        XCTAssertNotNil(responseSUT, "Fetched items is nil")
        XCTAssertEqual(responseSUT?.paging.total, 50, "Fetched items hasn't expected total paging")
        XCTAssertEqual(responseSUT?.results.count, 1, "Fetched items hasn't expected total results")
    }
    
    func testFetchItemsShouldReturnError() {
        // Given
        guard let marketApiStoreSpy = sut.store as? MarketApiSpy else {
            XCTAssert(false)
            return
        }
        let request = Items.FetchItems.Request(countryID: "MCO", query: "celular")
        var responseSUT: Items.FetchItems.Response?
        marketApiStoreSpy.fetchSearchError = .CannotFetch("is empty")
        var errorResponseSUT: SearchError?
        
        // When
        let expectation = XCTestExpectation(description: "Wait for fetched items result")
        sut.fetchItems(request: request) { (response, error) -> Void in
            responseSUT = response
            errorResponseSUT = error
            expectation.fulfill()
        }
        
        // Then
        XCTAssert(marketApiStoreSpy.fetchedItemsCalled, "Calling fetchItems() should ask the data store for a list of items")
        wait(for: [expectation], timeout: 2)
        XCTAssertNil(responseSUT, "Fetched items is not nil")
        XCTAssertEqual(errorResponseSUT?.rawMessage, "is empty", "Fetched error response is not cannot fetch")
    }
}
