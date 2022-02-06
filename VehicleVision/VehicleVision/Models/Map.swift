//
//  Map.swift
//  VehicleVision
//
//  Created by Jacqueline Palevich on 2/5/22.
//

import Foundation
import SwiftUI

struct Map {
    var lines: [Line]
    
    init() {
        lines = []
    }
    
    init(lines: [Line]){
        self.lines = lines
    }
}


func testMap() -> Map {
    let a = Station(p: CGPoint(x: 2, y: 7))
    let b = Station(p: CGPoint(x: 5, y: 3))
    let c = Station(p: CGPoint(x: 8, y: 5))
    
    let aTob = Segment(a: a, b: b)
    let bToc = Segment(a: b, b: c)
    
    let line1 = Line(segments: [aTob, bToc])
    
    let map = Map(lines: [line1])
    
    return map
}
