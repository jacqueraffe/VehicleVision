//
//  ClosestPoint.swift
//  VehicleVision
//
//  Created by Jacqueline Palevich on 5/24/22.
//

import Foundation
import SwiftUI

func closestPoint(p0: CGPoint, p1: CGPoint, l: CGPoint)-> (parametricDistance: CGFloat, distFromLine: CGFloat) {
    let x1 = p1.x
    let x = p0.x
    let y = p0.y
    let y1 = p1.y
    let px = l.x
    let py = l.y
    
    let vx = x1 - x  // vector of line
    let vy = y1 - y
    let ax = px - x  // vector from line start to point
    let ay = py - y
    var u = (ax * vx + ay * vy) / (vx * vx + vy * vy) // unit distance on line
    if !u.isFinite{
        u = 0
    }
    u = max(0, min(u, 1))
    let dx = x + vx * u
    let dy = y + vy * u
    let dist = sqrt(dx.magnitudeSquared + dy.magnitudeSquared)
    return (parametricDistance: u, distFromLine: dist)
}
