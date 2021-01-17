//
//  MoveCursorFaceAnchor.swift
//  AcessibilityFaceMovimentBR
//
//  Created by Joao Batista on 11/01/21.
//  Copyright © 2021 Joao Batista. All rights reserved.
//

import UIKit

final class MoveCursorFaceAnchor {

  // MARK: - Private Property

  private var lastPosition = CGPoint(x: Constants.Cursor.x, y: Constants.Cursor.y)
  private var lastFacePosition = CGPoint.zero
  private var isInitial = false
  private var toleranceX: CGFloat = 0.0037
  private var toleranceY: CGFloat = 0.1
  private let valueMovimentBase: CGFloat
  private var valueMoviment: CGFloat = 0
  // MARK: - Life Cicle

  init(valueMoviment: CGFloat) {
    self.valueMovimentBase = valueMoviment
    self.valueMoviment = valueMoviment
  }

  // MARK: - Private Method

  private func verifyIsInitial(withPoint point: CGPoint) {
    if isInitial {
      lastFacePosition = point
      isInitial = false
    }
  }

  private func verifyDirectionMove(withCoordinate coordinate: CGFloat, andLastCoordinate lastCoordinate: CGFloat) -> MovimentDirection {
    if abs(coordinate - lastCoordinate) < toleranceX {
      return .stop
    } else {
      updateValueMoviment(withValue: abs(coordinate - lastCoordinate).truncate())
    }

    if coordinate > lastCoordinate {
        return .positive
    } else {
        return .negative
    }
  }

  private func verifyIsStopFace(withPoint point: CGPoint) -> Bool {
    let stopX = (abs(point.x - lastPosition.x) > toleranceX)
    let stopY = (abs(point.y - lastPosition.y) > toleranceY)
    return (stopX && stopY)
  }

  private func updateValueMoviment(withValue value: CGFloat) {
    switch value {
    case ..<0.01:
      valueMoviment *= 1.3
    case ..<0.05:
      valueMoviment *= 1.5
    case ..<0.1:
      valueMoviment *= 2.0
    case ..<0.2:
      valueMoviment *= 2.3
    case ..<0.4:
      valueMoviment *= 3
    default:
      valueMoviment *= 5
    }
  }
}

// MARK: - Extensions

extension MoveCursorFaceAnchor: MoveCursorProtocol, MoveCursorUtilsProtocol {
  func set(initialPosition initial: CGPoint) {
    lastPosition = initial
  }

  func getNextPosition(withPoint point: CGPoint) -> CGPoint {
    var newPositionCursor = lastPosition
    verifyIsInitial(withPoint: point)

    let movimentX = verifyDirectionMove(withCoordinate: point.x, andLastCoordinate: lastFacePosition.x)

    switch movimentX {
    case .positive:
      newPositionCursor.x += valueMoviment
      lastFacePosition = point
    case .negative:
      newPositionCursor.x -= valueMoviment
      lastFacePosition = point
    case .stop:
      newPositionCursor = lastPosition
      lastFacePosition = point
    }

    if newPositionCursor.x < 0 || newPositionCursor.x > Constants.Screen.width {
      newPositionCursor = lastPosition
    }
    
    lastPosition = newPositionCursor
    valueMoviment = valueMovimentBase
    return newPositionCursor
  }
}
