////
////  MoveCursorFaceAnchor.swift
////  AcessibilityFaceMovimentBR
////
////  Created by Joao Batista on 11/01/21.
////  Copyright © 2021 Joao Batista. All rights reserved.
////
//
//import UIKit
//
//final class MoveCursorFaceAnchor {
//
//  // MARK: - Private Property
//
//  private var lastPosition = CGPoint(x: Constants.Cursor.x, y: Constants.Cursor.y)
//  private var lastFacePosition = CGPoint.zero
//  private var isInitial = false
//  private var toleranceX: CGFloat = 0.0037
//  private var toleranceY: CGFloat = 0.004
//  private let valueMovimentBase: CGFloat
//  private var valueMoviment: CGFloat = 0
//
//  // MARK: - Life Cicle
//
//  init(valueMoviment: CGFloat) {
//    self.valueMovimentBase = valueMoviment
//    self.valueMoviment = valueMoviment
//
//  }
//
//  // MARK: - Private Method
//
//  private func verifyIsInitial(withPoint point: CGPoint) {
//    if isInitial {
//      lastFacePosition = point
//      isInitial = false
//    }
//  }
//
//  private func verifyDirectionMove(withCoordinate coordinate: CGFloat, theLastCoordinate lastCoordinate: CGFloat, andTolerance tolerance: CGFloat) -> MovimentDirection {
//    if abs(coordinate - lastCoordinate) < tolerance {
//      return .stop
//    }
//
//    if coordinate > lastCoordinate {
//      return .positive
//    } else {
//      return .negative
//    }
//  }
//
//  private func verifyIsStopFace(withPoint point: CGPoint) -> Bool {
//    let stopX = (abs(point.x - lastPosition.x) > toleranceX)
//    let stopY = (abs(point.y - lastPosition.y) > toleranceY)
//    return (stopX && stopY)
//  }
//
//  private func updateValueMoviment(withValue value: CGFloat) {
//    switch value {
//    case ..<0.01:
//      valueMoviment *= 1.3
//    case ..<0.05:
//      valueMoviment *= 1.5
//    case ..<0.1:
//      valueMoviment *= 2.0
//    case ..<0.2:
//      valueMoviment *= 2.3
//    case ..<0.4:
//      valueMoviment *= 3
//    default:
//      valueMoviment *= 5
//    }
//  }
//
//  private func getNewPosition(withDirectioX directionX: MovimentDirection, theDirectionY directionY: MovimentDirection, andPointPosition position: CGPoint) -> CGPoint {
//    var newPosition = position
//
//    switch (directionX, directionY) {
//
//    case (.positive, .positive):
//      newPosition.x += valueMoviment
//      newPosition.y += (valueMoviment + valueMoviment/2)
//
//    case (.positive, .negative):
//      newPosition.x += valueMoviment
//      newPosition.y -= (valueMoviment + valueMoviment/2)
//
//    case (.positive, .stop):
//      newPosition.x += (valueMoviment + valueMoviment/2)
//
//    case (.negative, .positive):
//      newPosition.x -= valueMoviment
//      newPosition.y += (valueMoviment + valueMoviment/2)
//
//    case (.negative, .negative):
//      newPosition.x -= valueMoviment
//      newPosition.y -= (valueMoviment + valueMoviment/2)
//
//    case (.negative, .stop):
//      newPosition.x -= valueMoviment
//
//    case (.stop, .positive):
//      newPosition.y += (valueMoviment + valueMoviment/2)
//
//    case (.stop, .negative):
//      newPosition.y -= (valueMoviment + valueMoviment/2)
//
//    default:
//      return newPosition
//    }
//
//    return newPosition
//  }
//}
//
//// MARK: - Extensions
//
//extension MoveCursorFaceAnchor: MoveCursorProtocol, MoveCursorUtilsProtocol {
//  func set(initialPosition initial: CGPoint) {
//    lastPosition = initial
//  }
//
//  func getNextPosition(withPoint point: CGPoint) -> CGPoint {
//    verifyIsInitial(withPoint: point)
//
//    let movimentX = verifyDirectionMove(withCoordinate: point.x, theLastCoordinate: lastFacePosition.x, andTolerance: toleranceX)
//    let movimentY = verifyDirectionMove(withCoordinate: point.y, theLastCoordinate: lastFacePosition.y, andTolerance: toleranceY)
//
//    var newPositionCursor  = getNewPosition(withDirectioX: movimentX, theDirectionY: movimentY, andPointPosition: lastPosition)
//    print("###########-MOVIMENT-###########")
//    print(movimentX)
//    print(movimentY)
//
//    if newPositionCursor.x < 0 || newPositionCursor.x > Constants.Screen.width {
//      newPositionCursor.x = lastPosition.x
//    }
//    if newPositionCursor.y < 0 || newPositionCursor.y > Constants.Screen.heigh {
//      newPositionCursor.y = lastPosition.y
//    }
//
//    lastPosition = newPositionCursor
//    valueMoviment = valueMovimentBase
//    lastFacePosition = point
//    return newPositionCursor
//  }
//}
