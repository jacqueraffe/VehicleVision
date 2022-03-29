//
//  HomeView.swift
//  VehicleVision
//
//  Created by Jacqueline Palevich on 3/29/22.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var map : Map = testMap2()
    @State private var pressPlay = false
    @State var shouldHide = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Button("Play") {
                pressPlay.toggle()
                
            }.padding()
            .background(Color.white)
            .foregroundColor(.black)
            .font(.title)
            .border(Color.black, width: 5)
            .cornerRadius(5)
            //.opacity(shouldHide ? 0 : 1)
            
            if pressPlay {
                TimelineView(.animation(minimumInterval: 1.0 / 120)) { timeline in
                    MapView(map: map, date: timeline.date)
                }
            }
        }
    }
    
    
}
