//
//  ContentView.swift
//  VehicleVision
//
//  Created by Jacqueline Palevich on 2/5/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var map : Map = testMap2()
    
    var body: some View {
        TimelineView(.animation(minimumInterval: 1.0 / 120)) { timeline in
            MapView(map: map, date: timeline.date)
        }
    }
}
