//
//  VehicleVisionTests.swift
//  VehicleVisionTests
//
//  Created by Jacqueline Palevich on 2/6/22.
//
import XCTest

@testable import VehicleVision

class VehicleVisionTests: XCTestCase {
    var map: Map!

    override func setUpWithError() throws {
         map = testMap1()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
