//
//  Map.swift
//  VehicleVision
//
//  Created by Jacqueline Palevich on 2/5/22.
//

import Foundation
import SwiftUI

class Map : Actor , ObservableObject {
    @Published var lines: [Line]
    
    init() {
        lines = []
    }
    
    init(lines: [Line]){
        self.lines = lines
    }
    
    func tick(delta: TimeInterval) {
        for line in lines {
            line.tick(delta: delta)
        }
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
    
    let a2ToConnection = Segment(a: a2, b: connection)
    let ConnectionTob2 = Segment(a: connection, b: b2)
    let b2Toc2 = Segment(a: b2, b: c2)
    
    let car = Car(pos: a2ToConnection, segPos: 0)
    a2ToConnection.cars.append(car)
    
    let line1 = Line(segments: [a1Tob1, b1ToConnection], color: .red)
    
    let line2 = Line(segments: [a2ToConnection, ConnectionTob2, b2Toc2], color: .yellow)
    
    
    let map = Map(lines: [line1, line2])
    
    return map
}
