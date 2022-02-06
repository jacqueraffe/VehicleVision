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
    init(a: Station, b: Station) {
        self.a = a
        self.b = b
    }
}
