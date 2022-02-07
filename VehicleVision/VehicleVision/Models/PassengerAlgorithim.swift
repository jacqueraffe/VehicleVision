//
//  PassengerAlgorithim.swift
//  VehicleVision
//
//  Created by Jacqueline Palevich on 2/6/22.
//

import Foundation

/// chooses closest station of passenger type
func chooseStation(currentStation: Station, passengerType: StationType) throws -> [Station] {
    
    func visit(s: Station, visited: Set<Station.ID>) -> [Station]? {
        if visited.contains(s.id) {
            return nil
        } else if s.stationType == passengerType {
            return [s]
        } else {
            var v2 = visited
            v2.insert(s.id)
            for p in s.peers {
                if let path = visit(s: p, visited: v2) {
                    return [s] + path
                }
            }
            return nil
        }
    }
    
    return visit(s: currentStation, visited: []) ?? []
}
