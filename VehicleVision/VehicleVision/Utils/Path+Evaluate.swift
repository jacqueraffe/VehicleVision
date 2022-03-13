//
//  Path+Evaluate.swift
//  VehicleVision
//
//  Created by Jacqueline Palevich on 2/13/22.
//

import SwiftUI

fileprivate let defaultEpsilon = 1e-7

extension Path {
  
  /// Returns the position for a point on the path with the given
  /// fractional path value between 0 and 1.
  func evaluate(at: CGFloat,
      epsilon: CGFloat = defaultEpsilon,
      closed: Bool = false) -> CGPoint {
    // Make sure a and b don't go outside the bounds 0 ... 1.0
    var a = at
    var b = at + epsilon
    if closed {
      b = b.truncatingRemainder(dividingBy: 1.0)
    } else {
      if b > 1.0 {
        b = 1.0
        a = b - epsilon
      }
    }
    let littlePieceOfPathFromAToB = self.trimmedPath(from: a, to: b)
    let boundsOfLittlePiece = littlePieceOfPathFromAToB.boundingRect
    let positionOfA = boundsOfLittlePiece.origin
    return positionOfA
  }

  /// Returns the tangent angle in radians for a given fractional path value between 0 and 1.
  /// The tangent angle ranges from -π to π.
  /// An angle of 0 means the curve is pointing in the positive X direction.
  /// The angle increases in the clockwise direction.
  func evaluateTangent(at: CGFloat,
     lookAhead: CGFloat = defaultEpsilon,
     closed: Bool = false) -> CGFloat {
    var a = at
    var b = at + lookAhead
    if closed {
      b = b.truncatingRemainder(dividingBy: 1.0)
    } else {
      if b > 1.0 - lookAhead {
        b = 1.0 - lookAhead
        a = b - lookAhead
      }
    }
    let pa = evaluate(at: a)
    let pb = evaluate(at: b)
    return atan2(pb.y - pa.y, pb.x - pa.x)
  }
  
  /// Return the path length in pixels.
  var pathLength : CGFloat {
    let epsilon = 1e-7
    let sampleParameter = 0.0
    let a = sampleParameter
    let b = sampleParameter + epsilon
    let littlePieceOfPathFromAToB = self.trimmedPath(from: a, to: b)
    let boundsOfLittlePiece = littlePieceOfPathFromAToB.boundingRect
    let dx = boundsOfLittlePiece.width
    let dy = boundsOfLittlePiece.height
    let distance = sqrt(dx * dx + dy * dy)
    let pathLengthEstimate = distance / epsilon
    return pathLengthEstimate
  }
  
}
