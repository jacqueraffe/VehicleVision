//
//  Passenger.swift
//  VehicleVision
//
//  Created by Jacqueline Palevich on 2/5/22.
//

import Foundation

class Passenger {
    var destination: Station
    var stationType: StationType
    
    init(destination: Station, stationType: StationType){
        self.destination = destination
        self.stationType = stationType
    }
}

extension Passenger : Equatable {
    static func == (lhs: Passenger, rhs: Passenger) -> Bool {
        lhs.destination == rhs.destination && lhs.stationType == rhs.stationType
    }
}
