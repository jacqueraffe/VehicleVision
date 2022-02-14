//
//  PassengerAlgorithimTest.swift
//  VehicleVisionTests
//
//  Created by Jacqueline Palevich on 2/6/22.
//

import XCTest

@testable import VehicleVision

class PassengerAlgorithimTest: XCTestCase {
    var map: Map!
    let a1 = Station(p: CGPoint(x: 2, y: 7), stationType: .circle)
    let b1 = Station(p: CGPoint(x: 5, y: 3), stationType: .circle)
    
    let connection = Station(p: CGPoint(x: 1, y: 1), stationType: .triangle)
    
    let a2 = Station(p: CGPoint(x: 40, y: 3), stationType: .square)
    let b2 = Station(p: CGPoint(x: 4, y: 6), stationType: .square)
    let c2 = Station(p: CGPoint(x: 9, y: 15), stationType: .square)

    override func setUpWithError() throws {
        let a1Tob1 = Segment(a: a1, b: b1)
        let b1ToConnection = Segment(a: b1, b: connection)
        
        let a2ToConnection = Segment(a: a2, b: connection)
        let ConnectionTob2 = Segment(a: connection, b: b2)
        let b2Toc2 = Segment(a: b2, b: c2)
        
        
        let line1 = Line(segments: [a1Tob1, b1ToConnection], color: .red)
        
        let line2 = Line(segments: [a2ToConnection, ConnectionTob2, b2Toc2], color: .yellow)
        
        let map = Map(lines: [line1, line2])
        
        let scale = 5.0
        for i in 0..<map.lines.count {
            for j in 0..<map.lines[i].segments.count {
                map.lines[i].segments[j].a.p.x *= scale
                map.lines[i].segments[j].a.p.y *= scale
                map.lines[i].segments[j].b.p.x *= scale
                map.lines[i].segments[j].b.p.y *= scale
            }
        }
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFindPathAToB() throws {
        let path = try chooseStation(currentStation: a1, passengerType: .circle)
        
        XCTAssertEqual(path, [a1, b1])
    }
    
    func testFindPathAToE() throws {
        let path = try chooseStation(currentStation: a1, passengerType: .square)
        
        XCTAssertEqual(path, [a1, b1, connection, b2])
    }
    //fix test
    func testFindPathEToD() throws {
        let path = try chooseStation(currentStation: a2, passengerType: .square)
        
        XCTAssertEqual(path, [a2, b1])
    }


    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
