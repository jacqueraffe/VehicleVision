//
//  Station.swift
//  VehicleVision
//
//  Created by Jacqueline Palevich on 2/5/22.
//

import Foundation
import SwiftUI

class Station: Equatable{
    static func == (lhs: Station, rhs: Station) -> Bool {
        lhs.stationType == rhs.stationType && lhs.passengers == rhs.passengers && lhs.p == rhs.p && lhs.peers == rhs.peers
    }
    
    var passengers: Array<Passenger>
    var p: CGPoint
    var stationType: StationType
    var peers: [Station]
    
    init(p: CGPoint, stationType: StationType){
        passengers = Array()
        self.p = p
        self.stationType = stationType
        self.peers = []
    }
}
