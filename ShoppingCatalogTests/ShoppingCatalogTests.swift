//
//  ShoppingCatalogTests.swift
//  ShoppingCatalogTests
//
//  Created by Vaibhav N Laghane on 12/9/17.
//  Copyright © 2017 SClub. All rights reserved.
//

import XCTest
@testable import ShoppingCatalog

class ShoppingCatalogTests: XCTestCase {
    var  netCall:DataDownloader? = nil
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        netCall = DataDownloader()
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testURLCreation(){
        let url = netCall?.createURLFromParameters("30", "1")
        XCTAssertNotNil(url)
        print(url ?? " ");
    }
    
    func testNetworkCall(){
        let expectation = self.expectation(description: "fetch posts")
        //let url = netCall?.createURLFromParameters(pageSize: "30", pageNumber: "1")
        netCall?.getJSONData( pageNumber: 1, pageSize: 30, completion: { (dict ) in
            XCTAssertNotNil(dict)
            print(dict ?? "")
            expectation.fulfill()
        },failure: {( response, error) in
         //
        })
        self.waitForExpectations(timeout: 5.0, handler: nil)
    }
}
