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

func distanceBetween(p1: CGPoint, p2: CGPoint) -> CGFloat {
    let dx = p2.x - p1.x
    let dy = p1.y - p2.y
    return sqrt(dx * dx + dy * dy)
}

func findNearest(stations: [Station], p: CGPoint, maxDistance: CGFloat) -> Station? {
    var closestStation: Station?
    var smallestDistance = CGFloat.infinity
    for station in stations {
        let curDistance = distanceBetween(p1: p, p2: station.p)
        if  curDistance < smallestDistance {
            smallestDistance = curDistance
            closestStation = station
        }
    }
    if smallestDistance < maxDistance{
        return closestStation
    }
    return nil
}
