//
//  HomeView.swift
//  VehicleVision
//
//  Created by Jacqueline Palevich on 3/29/22.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var map : Map = testMap3()
    //for dev purposes, start out true
    @State private var gameMode = true
    
    var body: some View {
        
        VStack(alignment: .leading) {
            if !gameMode {
                Button("Play") {
                    gameMode.toggle()
                }.padding()
                    .background(Color.white)
                    .foregroundColor(.black)
                    .font(.title)
                    .border(Color.black, width: 5)
                    .cornerRadius(5)
            } else {
                TimelineView(.animation(minimumInterval: 1.0 / 120)) { timeline in
                    MapView(map: map, date: timeline.date)
                }
                
            }
        }
        
    }
    
    
}
