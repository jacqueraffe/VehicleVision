//
//  Map.swift
//  VehicleVision
//
//  Created by Jacqueline Palevich on 2/5/22.
//

// passenger, 
import Foundation
import SwiftUI

class Map : Actor , ObservableObject {
    @Published var lines: [Line]
    @Published var unattachedStations: [Station]
    @Published var unattachedPassengers: [Passenger]
    
    
    init(lines: [Line] = [], unattachedStations: [Station] = [], unattachedPassengers: [Passenger] = []){
        self.lines = lines
        self.unattachedStations = unattachedStations
        self.unattachedPassengers = unattachedPassengers
    }
    
    func tick(delta: TimeInterval) {
        for line in lines {
            line.tick(delta: delta)
        }
    }
    
    func closestStation(p: CGPoint) -> Station? {
        var allStations = unattachedStations
        for line in lines {
            for segment in line.segments {
                if !allStations.contains(segment.a){
                    allStations.append(segment.a)
                }
                if !allStations.contains(segment.b){
                    allStations.append(segment.b)
                }
            }
        }
        return findNearest(stations: allStations, p: p, maxDistance: 40)
    }
}



func testMap1() -> Map {
    let a = Station(p: CGPoint(x: 20, y: 70), stationType: .triangle)
    let b = Station(p: CGPoint(x: 50, y: 30), stationType: .circle)
    let c = Station(p: CGPoint(x: 80, y: 50), stationType: .triangle)
    
    let d = Station(p: CGPoint(x: 40, y: 60), stationType: .circle)
    let e = Station(p: CGPoint(x: 90, y: 150), stationType: .square)
    
    let aTob = Segment(a: a, b: b)
    let bToc = Segment(a: b, b: c)
    
    let cTod = Segment(a: c, b: d)
    let dToe = Segment(a: d, b: e)
    
    let line1 = Line(segments: [aTob, bToc], color: .red)
    
    let line2 = Line(segments: [cTod, dToe], color: .yellow)
    
    let map = Map(lines: [line1, line2])
    
    return map
}

func testMap2() -> Map {
    let a1 = Station(p: CGPoint(x: 20, y: 20), stationType: .circle)
    let b1 = Station(p: CGPoint(x: 100, y: 50), stationType: .circle)
    
    let connection = Station(p: CGPoint(x: 110, y: 70), stationType: .triangle)
    
    let a2 = Station(p: CGPoint(x: 180, y: 20), stationType: .square)
    let b2 = Station(p: CGPoint(x: 75, y: 100), stationType: .square)
    let c2 = Station(p: CGPoint(x: 50, y: 50), stationType: .square)
    
    let a1Tob1 = Segment(a: a1, b: b1)
    let b1ToConnection = Segment(a: b1, b: connection)
    
    let car1 = Car(pos: a1Tob1, segPos: 0)
    a1Tob1.cars.append(car1)
    
    let a2ToConnection = Segment(a: a2, b: connection)
    let ConnectionTob2 = Segment(a: connection, b: b2)
    let b2Toc2 = Segment(a: b2, b: c2)
    
    let car2 = Car(pos: a2ToConnection, segPos: 0)
    a2ToConnection.cars.append(car2)
    
    let line1 = Line(segments: [a1Tob1, b1ToConnection], color: .red)
    
    let line2 = Line(segments: [a2ToConnection, ConnectionTob2, b2Toc2], color: .yellow)
    
    
    let map = Map(lines: [line1, line2])
    
    return map
}

/// Most simple basic map with no line to begin with to test drawing lines.
func testMap3() -> Map {
    let a = Station(p: CGPoint(x: 40, y: 60), stationType: .circle)
    let b = Station(p: CGPoint(x: 200, y: 150), stationType: .circle)
    let c = Station(p: CGPoint(x: 100, y: 150), stationType: .square)
    
    let map = Map(unattachedStations: [a, b, c])
    
    return map
}

func demoMap() -> Map {
    // line1 assets
    let a1 = Station(p: CGPoint(x: 100, y: 250), stationType: .circle)
    let a2 = Station(p: CGPoint(x: 150, y: 300), stationType: .circle)
    
    let connection1 = Station(p: CGPoint(x: 200, y: 320), stationType: .triangle)
    
    let a1Toa2 = Segment(a: a1, b: a2)
    let a2ToConnection1 = Segment(a: a2, b: connection1)
    
    let car1 = Car(pos: a1Toa2, segPos: 0)
    a1Toa2.cars.append(car1)
    
    //line2 assets
    let b1 = Station(p: CGPoint(x: 220, y: 480), stationType: .square)
    let b2 = Station(p: CGPoint(x: 75, y: 350), stationType: .square)
    let b3 = Station(p: CGPoint(x: 50, y: 400), stationType: .square)
    
    let b1ToConnection1 = Segment(a: b1, b: connection1)
    let Connection1Tob2 = Segment(a: connection1, b: b2)
    let b2Tob3 = Segment(a: b2, b: b3)
    
    let car2 = Car(pos: a2ToConnection1, segPos: 0)
    b1ToConnection1.cars.append(car2)
    
    // line3 asseets
    let c1 = Station(p: CGPoint(x: 320, y: 250), stationType: .square)
    let c2 = Station(p: CGPoint(x: 275, y: 300), stationType: .square)
    let c3 = Station(p: CGPoint(x: 150, y: 375), stationType: .square)
    
    let c1Toc2 = Segment(a: c1, b: c2)
    let c2ToConnection1 = Segment(a: c2, b: connection1)
    let Connection1Toc3 = Segment(a: connection1, b: c3)
    
    let car3 = Car(pos: c2ToConnection1, segPos: 0)
    Connection1Toc3.cars.append(car3)
    
    //lines
    
    let line1 = Line(segments: [a1Toa2, a2ToConnection1], color: .red)
    
    let line2 = Line(segments: [b1ToConnection1, Connection1Tob2, b2Tob3], color: .yellow)
    
    let line3 = Line(segments: [c1Toc2, c2ToConnection1, Connection1Toc3], color: .blue)
    
    
    let map = Map(lines: [line1, line2, line3])
    
    return map
}

