//
//  Bet365TaskTests.swift
//  Bet365TaskTests
//
//  Created by Faraz on 27/12/2023.
//

import XCTest
@testable import Bet365Task

final class Bet365TaskTests: XCTestCase {

    // system under test
    var sut: GridViewModel?
    
    override func setUp() {
        super.setUp()
        
        sut = GridViewModel()
    }
    
    override func tearDown() {
        super.tearDown()
        
        sut = nil
    }
    
    func testGetSnapShot() {
        
        sut?.getSnapShot()
        
        XCTAssertFalse(sut?.finData.isEmpty ?? false, "Property should not be empty but was found to be empty")
    }
    
    func testGetDeltas() {
        
        sut?.getDeltas()
        
        XCTAssertFalse(sut?.delayTimes.isEmpty ?? false, "Property should not be empty but was found to be empty")
        XCTAssertFalse(sut?.deltas.isEmpty ?? false, "Property should not be empty but was found to be empty")
    }
    
    func testGetDeltasCallsProcessDeltas() {
        
        sut?.getDeltas()
        
        XCTAssertEqual(sut?.finData.count, 10)
        XCTAssertTrue(sut?.graphData.isEmpty ?? false)
    }

}
