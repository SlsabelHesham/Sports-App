//
//  MockTest.swift
//  SportsAppTests
//
//  Created by Mohamed Kotb Saied Kotb on 25/05/2024.
//

import XCTest
@testable import SportsApp

final class MockTest: XCTestCase {
    let mockObj = MockNetworkService(flag: false)
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testMockFetchData(){
        mockObj.fetchData{ result, error in
            
            if let error = error {
                XCTFail()
            } else {
                XCTAssertNotNil(result)
            }
            
        }
    }
}
