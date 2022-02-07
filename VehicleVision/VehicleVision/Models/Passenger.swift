//
//  Passenger.swift
//  VehicleVision
//
//  Created by Jacqueline Palevich on 2/5/22.
//

import Foundation

struct Passenger {
    var destination: Station
    var stationType: StationType
    
    init(destination: Station, stationType: StationType){
        self.destination = destination
        self.stationType = stationType
    }
}
