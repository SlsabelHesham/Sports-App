//
//  LeaguesViewModelTests.swift
//  SportsAppTests
//
//  Created by Slsabel Hesham on 26/05/2024.
//

import XCTest
@testable import SportsApp
final class LeaguesViewModelTests: XCTestCase {
    
    var viewModel: LeaguesViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = LeaguesViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testGetLeagues() {
        
        let expectation = self.expectation(description: "bindResultToLeaguesViewController")
        
        viewModel.bindResultToLeaguesViewController = {
            expectation.fulfill()
        }
        
        viewModel.getLeagues(sport: "Football")
        
        waitForExpectations(timeout: 16) { _ in
            XCTAssertEqual(self.viewModel.leagues?.count, 865)
            XCTAssertEqual(self.viewModel.leagues?.first?.league_name, "UEFA Europa League")
        }
    }
}

