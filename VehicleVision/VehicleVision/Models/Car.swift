//
//  Car.swift
//  VehicleVision
//
//  Created by Jacqueline Palevich on 2/5/22.
//

import Foundation

class Car : Actor {
    var passengers : [Passenger]
    var pos: Segment
    // 0 to 1
    var segPos: Double
    var travelingTowards1 : Bool
    // change in segmentpos per sec
    var speed: Double
    
    init(pos: Segment, segPos: Double){
        passengers = []
        self.pos = pos
        self.segPos = segPos
        travelingTowards1 = true
        speed = 0.2
    }
    
    func tick(delta: TimeInterval) {
        segPos = min(segPos+speed*delta, 1)
    }
    
}
