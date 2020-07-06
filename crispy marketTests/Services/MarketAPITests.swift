//
//  MarketAPITests.swift
//  crispy marketTests
//
//  Created by guillermo on 7/1/20.
//  Copyright © 2020 guillodacosta. All rights reserved.
//

import XCTest
import Nimble
import OHHTTPStubs
import OHHTTPStubsSwift
@testable import crispy_market

class MarketAPITests: XCTestCase {
    
    private let apiClient = MarketAPI(apiLog: MarketLogApiSpy())

    override func setUp() {
        super.setUp()
        HTTPStubs.onStubMissing() { request in
            XCTFail("Missing stub for \(request)")
        }
    }

    override func tearDown() {
        HTTPStubs.removeAllStubs()
        super.tearDown()
    }

    // MARK: Test doubles
    
    class MarketLogApiSpy: MarketLogAPI {}
    
    
    // MARK: Tests
    
    func testParsesItemsProperlyGettingAllItems() {
        // Given
        stub(condition: isHost("api.mercadolibre.com")) { request in
            guard let file = OHPathForFile("getItemsResponse.json", type(of: self)) else {
                return HTTPStubsResponse()
            }
            return HTTPStubsResponse(
                fileAtPath: file,
                statusCode: 200,
                headers: ["Content-Type": "application/json"]
            )
        }
        let expectation = XCTestExpectation(description: "Complete download network")
        var result: Items.FetchItems.Response?
        let request = Items.FetchItems.Request(countryID: "MCO", query: "iphone")
        
        // When
        apiClient.fetchItems(request: request) { response, err  in
            result = response
            expectation.fulfill()
        }

        // Then
        wait(for: [expectation], timeout: 5)
        assertFirstItemContainsExpectedValues((result?.results[0])!)
    }
    
    func testCountItemsResult() {
        stub(condition: isHost("api.mercadolibre.com")) { request in
            guard let file = OHPathForFile("getItemsResponse.json", type(of: self)) else {
                return HTTPStubsResponse()
            }
            return HTTPStubsResponse(
                fileAtPath: file,
                statusCode: 200,
                headers: ["Content-Type": "application/json"]
            )
        }
        let expectation = XCTestExpectation(description: "Complete download network")
        var result: Items.FetchItems.Response?
        let request = Items.FetchItems.Request(countryID: "MCO", query: "iphone")
        apiClient.fetchItems(request: request) { response, err  in
            result = response
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 3)
        expect { result?.results.count }.toEventually(equal(50))
    }

    func testReturnsNetworkErrorIfThereIsNoConnectionGettingItems() {
        stub(condition: isHost("api.mercadolibre.com")) { _ in
            let notConnectedError = NSError(domain: NSURLErrorDomain,
                                            code: URLError.notConnectedToInternet.rawValue)
            return HTTPStubsResponse(error: notConnectedError)
        }

        let expectation = XCTestExpectation(description: "Complete download network")
        let request = Items.FetchItems.Request(countryID: "MCO", query: "iphone")
        var result: SearchError?
        apiClient.fetchItems(request: request) { response, err  in
            result = err
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 3)
        expect { result?.rawMessage }.to(equal("URLSessionTask failed with error: The operation couldn’t be completed. (NSURLErrorDomain error -1009.)"))
    }
    
    func testReturnsHoustonErrorIfThereIsBadInformation() {
        stub(condition: isHost("api.mercadolibre.com")) { request in
            let jsonObject = ["key": "value"]
            return HTTPStubsResponse(jsonObject: jsonObject, statusCode: 200, headers: ["Content-Type": "application/json"])
        }

        let expectation = XCTestExpectation(description: "Complete download network")
        let request = Items.FetchItems.Request(countryID: "MCO", query: "iphone")
        var result: SearchError?
        apiClient.fetchItems(request: request) { response, err  in
            result = err
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 3)
        expect { result?.rawMessage }.to(equal("Houston we are in troubles!"))
    }

    private func assertFirstItemContainsExpectedValues(_ item: Items.FetchItems.ViewModel) {
        expect(item.id).to(equal("MCO535644103"))
        expect(item.thumbnail).to(equal("http://mco-s2-p.mlstatic.com/702463-MCO32804475462_112019-I.jpg"))
        expect(item.title).to(equal("Celular iPhone 11 Pro Max De 256gb Libre, Sellado "))
        expect(item.siteID).to(equal("MCO"))
        expect(item.price).to(equal(5859000))
    }

}
