//
//  SwiftUIView.swift
//  VehicleVision
//
//  Created by Jacqueline Palevich on 2/5/22.
//

import SwiftUI

struct MapView: View {
    @State var map : Map = testMap()
    
    var body: some View {
        Canvas { context, size in
            context.scaleBy(x: size.width/10.0, y: size.height/20.0)
            let pixelWidth = 10/size.width
            let lineWidth = 2*pixelWidth
            let stationWidth = 10*pixelWidth
            for line in map.lines {
                var path = Path()
                //draw path
                for segment in line.segments {
                    if path.currentPoint == nil {
                        path.move(to: segment.a.p)
                    }
                    path.addLine(to: segment.b.p)
                }
                context.stroke(path, with: .color(.red), lineWidth: lineWidth)
                
                //draw points
                var firstTime: Bool = true
                for segment in line.segments {
                    if firstTime{
                        firstTime = false
                        drawStation(context: context, s: segment.a, stationWidth: stationWidth)
                    }
                    drawStation(context: context, s: segment.b, stationWidth: stationWidth)
                }
            }
            
        }
    }
    
    func drawStation(context: GraphicsContext, s: Station, stationWidth: CGFloat){
        let w2 = stationWidth*0.5
        let stationRect = CGRect(x: s.p.x-w2, y: s.p.y-w2, width: stationWidth, height: stationWidth)
        context.fill(Path(ellipseIn: stationRect), with: .color (.black))
    }
}
