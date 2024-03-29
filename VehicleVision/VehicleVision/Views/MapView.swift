//
//  SwiftUIView.swift
//  VehicleVision
//
//  Created by Jacqueline Palevich on 2/5/22.
//

import SwiftUI
import UIKit

// goals: make train, debug make line
// also make test map for demo
// line menu

struct MapView: View {
    @ObservedObject var map : Map
    //state object so prev date stays prev date, stays whole time
    @State var prevDate = Date()
    let date : Date
    
    //vibrations
    let generator = UINotificationFeedbackGenerator()
    
    @GestureState private var dragState = DragState.inactive
    
    var body: some View {
        canvas
            .gesture(
                DragGesture()
                    .updating($dragState){ currentState, gestureState, transaction in
                        switch gestureState {
                        case .inactive:
                            gestureState = makeLineMethod(action: currentState)
                            if case .inactive = gestureState {
                                let (nearTrainButton, gState) = calculateMakeTrain(action: currentState)
                                if nearTrainButton {
                                    gestureState = gState
                                }
                            }
                        case .makeLine:
                            gestureState = makeLineMethod(action: currentState)
                        case .makeTrains:
                            let (_, gState) = calculateMakeTrain(action: currentState)
                            gestureState = gState
                        case .deleteSegment:
                            break
                        }
                    }
//                //dig more into documentation figure out how to mb extract info
//                    .onEnded({ gestureState in
//                        switch gestureState {
//                        case .makeTrains:
//                            break
//                        default :
//                            break
//                        }
//                    })
            )
    }
    
    var canvas : some View {
        Canvas { context, size in
            drawMap(context: context)
            drawTrainButton(context: context)
            if case let .makeTrains(p: p) = dragState {
                drawMakeTrains(context: context, p: p)
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
        //restore the transfor here the pen
        context.transform = oldTransform
    }
    
    func drawTrainButton(context: GraphicsContext){
        var context = context
        let oldTransform = context.transform
        let stationRect = CGRect(x: 325, y: 375, width: 45, height: 45)
        var path = Path(ellipseIn: stationRect)
        //context.fill(path, with: .color(.white))
        context.stroke(path, with: .color (.black), lineWidth: 2.5)
        // new transform to draw car
        context.transform = oldTransform
            .translatedBy(x: 340, y: 392.5)
        let car = CGRect(x: 0, y: 0, width: 15, height: 10)
        path = Path(car)
        context.fill(path, with: .color(.black))
        //draw passengers here
        //restore the transfor here the pen
        context.transform = oldTransform
    }
    
    func drawStation(context: GraphicsContext, s: Station){
        let selectedStation = isStationSelected(s: s)
        let stationWidth = selectedStation ? 20.0 : 10.0
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
    
    func isStationSelected(s: Station) -> Bool {
        if case let .makeLine (station, _) = dragState {
            return s == station
        } else {
            return false
        }
    }
    
    func drawMap (context: GraphicsContext){
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
                //find length of segment
                let segmentLength = pathLengthToStartOfSegment[i+1] - pathLengthToStartOfSegment[i]
                
                var carsToBeMovedToNextSegment = [Int]()
                for (j, car) in segment.cars.enumerated(){
                    //where it is
                    let pathLengthToCarPosition = (pathLengthToStartOfSegment[i] + car.segPos*segmentLength)/pathLength
                    drawCar(context: context, path: path, animationProgress: pathLengthToCarPosition)
                    if car.atEndOfSegment {
                        carsToBeMovedToNextSegment.append(j)
                    }
                }
                for j in carsToBeMovedToNextSegment.reversed(){
                    let car = segment.cars.remove(at: j)
                    //change num passengers here
                    if car.travelingTowards1 {
                        if i == line.segments.count-1 {
                            car.travelingTowards1.toggle()
                            line.segments[i].cars.append(car)
                        } else {
                            line.segments[i+1].cars.append(car)
                        }
                    } else {
                        if i == 0 {
                            car.travelingTowards1.toggle()
                            line.segments[i].cars.append(car)
                        } else {
                            line.segments[i-1].cars.append(car)
                        }
                    }
                    car.segPos = car.begOfSeg
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
        //draw unattatched stations
        for station in map.unattachedStations {
            drawStation(context: context, s: station)
        }
    }
    
    func drawPassengers (context: GraphicsContext){
        
    
    }
    
    // returns dragState which will be .inactive if not near line
    func makeLineMethod(action:  DragGesture.Value) -> DragState{
        if let station = map.closestStation(p: action.location) {
            switch dragState {
            case .inactive:
                return .makeLine(station: station, line: nil)
            case .makeLine(station: let station0, line: var line0):
                if station0 != station {
                    generator.notificationOccurred(.success)
                    let connection = Segment(a: station0, b: station)
                    //TODO: check if connection already exists
                    if line0 == nil {
                        line0 = Line(segments: [connection], color: .green)
                        map.lines.append(line0!)
                    } else {
                        line0?.segments.append(connection)
                    }
                }
                return .makeLine(station: station, line: line0)
            default :
                return .inactive
            }
        }
        return .inactive
    }
    
    func drawMakeTrains(context: GraphicsContext, p: CGPoint){
        let car = CGRect(x: p.x, y: p.y, width: 15, height: 10)
        let path = Path(car)
        context.fill(path, with: .color(.gray))
    }
    
    /// Bool is true if you are near the train button
    func calculateMakeTrain(action:  DragGesture.Value) -> (Bool, DragState){
        let l = action.location
        let dx = l.x - 347.5
        let dy = l.y - 397.5
        let dist = sqrt(dx * dx + dy * dy)
        return (dist <= 30, .makeTrains(p: action.location) )
    }
    
    func pickTrainPositionOnLine(p: CGPoint) -> (s: Segment, parametricDist: CGFloat)? {
        var s: Segment?
        var minActualDist: CGFloat?
        var minParametericDist: CGFloat?
        for line in map.lines {
            for segment in line.segments {
                let closestPointResult = closestPoint(p0: segment.a.p, p1: segment.b.p, l: p)
                if closestPointResult.distFromLine < minActualDist ?? CGFloat.infinity {
                    minParametericDist = closestPointResult.parametricDistance
                    minActualDist = closestPointResult.distFromLine
                    s = segment
                }
            }
        }
        if let s = s, let minParametericDist = minParametericDist {
            return (s, minParametericDist)
        }
        return nil
    }
    
    //            func calculateSwitchLine(action:  DragGesture.Value, path: Path){
    //                let l = action.location
    //                //switchLine = path.contains(l)
    //            }
}

enum DragState {
    case inactive
    case makeTrains (p : CGPoint)
    //TODO: if near line, can take segment away
    case deleteSegment
    // Line is nil until the second station appears
    case makeLine (station : Station, line: Line?)
}


//demo:
/*
 logic:
 explain geometry and draggin stuff, don't explain swift concepts
 talk about enum to keep track of state, but don't go into detail about what each thing means
 
 
 what my app is made of:
 my data structures
 
 demo will have code in background
 
 well:
 I learned animation
 better understanding of swift/views
 Because of this project + mr broman: Forced to try to actually understand what was happening i my code. for example look back through retros to find example
 learned more this semester
 specefic examples
 
 badly:
 didn't accomplish
 kinda got senioritus
 \
 ask about target learning in Your project objectives / product purpose  section
 */
