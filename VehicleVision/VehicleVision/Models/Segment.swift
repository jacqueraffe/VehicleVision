//
//  Segment.swift
//  VehicleVision
//
//  Created by Jacqueline Palevich on 2/5/22.
//

import Foundation

class Segment : Actor {
    var a: Station
    var b: Station
    var cars: [Car]
    
    init(a: Station, b: Station) {
        self.a = a
        self.b = b
        cars = []
        a.peers.append(b)
        b.peers.append(a)
    }
    
    func tick(delta: TimeInterval) {
        for car in cars {
            car.tick(delta: delta)
        }
    }
    
}
