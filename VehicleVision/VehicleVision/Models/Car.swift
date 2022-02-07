//
//  Car.swift
//  VehicleVision
//
//  Created by Jacqueline Palevich on 2/5/22.
//

import Foundation

class Car {
    var passengers : [Passenger]
    var pos: Segment
    // 0 to 1
    var segPos: Double
    var travelingTowards1 : Bool
    
    init(pos: Segment, segPos: Double){
        passengers = []
        self.pos = pos
        self.segPos = segPos
        travelingTowards1 = true
    }
}
