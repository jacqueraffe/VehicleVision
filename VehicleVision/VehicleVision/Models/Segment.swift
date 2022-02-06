//
//  Segment.swift
//  VehicleVision
//
//  Created by Jacqueline Palevich on 2/5/22.
//

import Foundation

struct Segment {
    var a: Station
    var b: Station
    var cars: [Car]
    
    init(a: Station, b: Station) {
        self.a = a
        self.b = b
        cars = []
    }
}
