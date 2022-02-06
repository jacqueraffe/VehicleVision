//
//  Line.swift
//  VehicleVision
//
//  Created by Jacqueline Palevich on 2/5/22.
//

import Foundation

struct Line {
    var segments: Array<Segment> = Array()
    init(segments: Array<Segment>) {
        self.segments = segments
        }
}
