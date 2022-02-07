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
    let a = Station(p: CGPoint(x: 2, y: 7), stationType: .triangle)
    let b = Station(p: CGPoint(x: 5, y: 3), stationType: .circle)
    let c = Station(p: CGPoint(x: 8, y: 5), stationType: .triangle)
    
    let d = Station(p: CGPoint(x: 4, y: 6), stationType: .circle)
    let e = Station(p: CGPoint(x: 9, y: 15), stationType: .square)
    
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
    return map
}
