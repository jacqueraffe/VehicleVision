//
//  Station.swift
//  VehicleVision
//
//  Created by Jacqueline Palevich on 2/5/22.
//

import Foundation
import SwiftUI

class Station {
    var passengers: Array<Passenger>
    var p: CGPoint
    var stationType: StationType
    var peers: [Station]
    var id: Int
    
    static var nextId: Int = 0
    
    init(p: CGPoint, stationType: StationType){
        passengers = Array()
        self.p = p
        self.stationType = stationType
        self.peers = []
        self.id = Station.nextId
        Station.nextId += 1
    }
    
}

extension Station : Equatable {
    static func == (lhs: Station, rhs: Station) -> Bool {
        lhs.stationType == rhs.stationType && lhs.passengers == rhs.passengers && lhs.p == rhs.p && lhs.peers == rhs.peers
    }
}

extension Station : Identifiable {
    // Identifiable protocol satisfied by var id
}

extension Station :  CustomStringConvertible{
    var description: String {
        "\(id)"
    }
}
