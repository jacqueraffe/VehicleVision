//
//  Station.swift
//  VehicleVision
//
//  Created by Jacqueline Palevich on 2/5/22.
//

import Foundation
import SwiftUI

class Station{
    var passengers: Array<Passenger>
    var p: CGPoint
    
    init(p: CGPoint){
        passengers = Array()
        self.p = p
    }
}
