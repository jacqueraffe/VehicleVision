//
//  Path+HitTest.swift
//  VehicleVision
//
//  Created by Jacqueline Palevich on 5/24/22.
//

import Foundation
import SwiftUI

extension Path {
    
    /// returns a value btw 0 and 1 that is the paramtetric dstance along the path thtat's closest to the point passed in
    func hitTest (p: CGPoint) -> (parametricDistance: CGFloat, distFromLine: CGFloat){
        let pathLength = self.pathLength
        var minDist: CGFloat?
        var result: CGFloat = 0
        for index in stride(from: 0, through: pathLength, by: 5){
            let unitDistAlongPath = index / pathLength
            let testPoint = evaluate(at: unitDistAlongPath)
            let l = testPoint
            let dx = l.x - p.x
            let dy = l.y - p.y
            let dist = (dx * dx + dy * dy)
            if minDist ?? CGFloat.infinity > dist {
                minDist = dist
                result = index
            }
        }
        return (result, minDist!)
    }
    
}
