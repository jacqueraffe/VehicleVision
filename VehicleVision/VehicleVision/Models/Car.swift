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
    var atEndOfSegment : Bool {
        segPos == endOfSeg
    }
    var begOfSeg : Double {
        if travelingTowards1 {
            return 0.0
        } else {
            return 1.0
        }
    }
    var endOfSeg : Double {
        if travelingTowards1 {
            return 1.0
        } else {
            return 0.0
        }
    }
    
    init(pos: Segment, segPos: Double){
        passengers = []
        self.pos = pos
        self.segPos = segPos
        travelingTowards1 = true
        speed = 0.2
    }
    
    func tick(delta: TimeInterval) {
        if travelingTowards1{
            segPos = min(segPos+speed*delta, 1)
        } else {
            segPos = max(segPos-speed*delta, 0)
        }
        
    }
    
}
