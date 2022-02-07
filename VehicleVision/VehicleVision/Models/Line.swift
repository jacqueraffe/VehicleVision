//
//  Line.swift
//  VehicleVision
//
//  Created by Jacqueline Palevich on 2/5/22.
//

import Foundation
import SwiftUI

class Line {
    var segments: Array<Segment> = Array()
    var color: Color
    
    init(segments: Array<Segment>, color: Color) {
        self.segments = segments
        self.color = color
        }
}
