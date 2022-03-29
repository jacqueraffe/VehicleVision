//
//  SwiftUIView.swift
//  VehicleVision
//
//  Created by Jacqueline Palevich on 2/5/22.
//

import SwiftUI
// questions: self is immutable what makes map view immutable, what makes the objects immutable
// why is mapView immutable and does that apply to other objects
// @State how does it work to be mutable all of a sudden
struct MapView: View {
    @ObservedObject var map : Map
    //state object so prev date stays prev date, stays whole time
    @State var prevDate = Date()
    let date : Date
    
    var body: some View {
        canvas
    }
    
    var canvas : some View {
        Canvas { context, size in
            let lineWidth = 3.0
            for line in map.lines {
                var path = Path()
                //draw path and calculate segment fraction starts
                var pathLengthToStartOfSegment = [Double]()
                for segment in line.segments {
                    if path.currentPoint == nil {
                        path.move(to: segment.a.p)
                    }
                    path.addLine(to: segment.b.p)
                    pathLengthToStartOfSegment.append(path.pathLength)
                }
                context.stroke(path, with: .color(line.color), lineWidth: lineWidth)
                
                pathLengthToStartOfSegment.insert(0, at: 0)
                
                let pathLength = pathLengthToStartOfSegment.last!
                //draw cars
                for (i, segment) in line.segments.enumerated() {
                    //change to go along path so it can turn
                    //find length of segment
                    let segmentLength = pathLengthToStartOfSegment[i+1] - pathLengthToStartOfSegment[i]
        
                    for car in segment.cars{
                        //where it is
                        let pathLengthToCarPosition = (pathLengthToStartOfSegment[i] + car.segPos*segmentLength)/pathLength
                        drawCar(context: context, path: path, animationProgress: pathLengthToCarPosition)
                    }
                }
                
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
        }.onChange(of: date){ date in
            let delta = date.timeIntervalSince(prevDate)
            prevDate = date
            map.tick(delta: delta)
        }
    }
    
    func drawCar(context: GraphicsContext, path: Path, animationProgress: Double){
        var context = context
        //find out where it is on the path
        let pos = path.evaluate(at:animationProgress)
        // Use a lookAhead to have the car smoothly animate around sharp corners
        let tangentAngle =
        path.evaluateTangent(at: animationProgress, lookAhead:0.01)
        //save old transform to restore later
        let oldTransform = context.transform
        // new transform to draw car
        context.transform = oldTransform
            .translatedBy(x: pos.x, y: pos.y)
            .rotated(by:tangentAngle)
        let car = CGRect(x: 0, y: 0, width: 15, height: 10)
        let path = Path(car)
        context.fill(path, with: .color(.black))
        //draw passengers here
        //restore
        context.transform = oldTransform
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
