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
    let a = Station(p: CGPoint(x: 2, y: 7), stationType: .triangle)
    let b = Station(p: CGPoint(x: 5, y: 3), stationType: .circle)
    let c = Station(p: CGPoint(x: 8, y: 5), stationType: .triangle)
    
    let d = Station(p: CGPoint(x: 4, y: 6), stationType: .circle)
    let e = Station(p: CGPoint(x: 9, y: 15), stationType: .square)

    override func setUpWithError() throws {
        let aTob = Segment(a: a, b: b)
        let bToc = Segment(a: b, b: c)
        
        let cTod = Segment(a: c, b: d)
        let dToce = Segment(a: d, b: e)
        
        let line1 = Line(segments: [aTob, bToc], color: .red)
        
        let line2 = Line(segments: [cTod, dToce], color: .yellow)
        
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

    func testFindPath() throws {
        let path = try chooseStation(currentStation: a, passengerType: .circle)
        
        XCTAssertEqual(path, [a, b])
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
