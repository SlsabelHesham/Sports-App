//
//  SportsAppTests.swift
//  SportsAppTests
//
//  Created by Slsabel Hesham on 25/05/2024.
//

import XCTest
@testable import SportsApp

final class SportsAppTests: XCTestCase {
    
    let teamsRequest = TeamRequest(sport: "football", leagueId: 207)

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testGetDataFromNetwork(){
        let expectation = expectation(description: "Wait For API ...")

        getDataFromNetwork(request: teamsRequest) { (result: TeamsResponse?) in
            XCTAssertNotNil(result, "not nil")
            XCTAssertEqual(result?.result.count , 20)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 2)

    }

}
