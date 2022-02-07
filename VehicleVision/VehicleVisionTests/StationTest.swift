//
//  StationTest.swift
//  VehicleVisionTests
//
//  Created by Jacqueline Palevich on 2/6/22.
//

import XCTest

@testable import VehicleVision

class StationTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testIdentity() throws {
        let a = Station(p: CGPoint(x: 2, y: 7), stationType: .triangle)
        let b = Station(p: CGPoint(x: 5, y: 3), stationType: .circle)
        
        XCTAssertNotEqual(a, b)
        XCTAssertNotEqual(a.id, b.id)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
