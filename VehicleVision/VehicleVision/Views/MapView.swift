//
//  SwiftUIView.swift
//  VehicleVision
//
//  Created by Jacqueline Palevich on 2/5/22.
//

import SwiftUI

struct MapView: View {
    @State var map : Map = testMap2()
    
    var body: some View {
        Canvas { context, size in
            let lineWidth = 3.0
            for line in map.lines {
                var path = Path()
                //draw path
                for segment in line.segments {
                    if path.currentPoint == nil {
                        path.move(to: segment.a.p)
                    }
                    path.addLine(to: segment.b.p)
                }
                context.stroke(path, with: .color(line.color), lineWidth: lineWidth)
                
                //draw points
                var firstTime: Bool = true
                for segment in line.segments {
                    if firstTime{
                        firstTime = false
                        drawStation(context: context, s: segment.a)
                    }
                    drawStation(context: context, s: segment.b)
                }
            }
            
        }
    }
    
    func drawStation(context: GraphicsContext, s: Station){
        let stationWidth = 10.0
        let lineWidth = 2.5
        switch s.stationType {
        case .triangle:
            let w2 = stationWidth*0.5
            let stationRect = CGRect(x: s.p.x-w2, y: s.p.y-w2, width: stationWidth, height: stationWidth)
            let path = Path(roundedRect: stationRect, cornerSize: CGSize(width: 3, height: 3))
            context.fill(path, with: .color(.white))
            context.stroke(path, with: .color (.black), lineWidth: lineWidth)
        case .square:
            let w2 = stationWidth*0.5
            let stationRect = CGRect(x: s.p.x-w2, y: s.p.y-w2, width: stationWidth, height: stationWidth)
            let path = Path(roundedRect: stationRect, cornerSize: .zero)
            context.fill(path, with: .color(.white))
            context.stroke(path, with: .color (.black), lineWidth: lineWidth)
        case .circle:
            let w2 = stationWidth*0.5
            let stationRect = CGRect(x: s.p.x-w2, y: s.p.y-w2, width: stationWidth, height: stationWidth)
            let path = Path(ellipseIn: stationRect)
            context.fill(path, with: .color(.white))
            context.stroke(path, with: .color (.black), lineWidth: lineWidth)
        }
    }
}
