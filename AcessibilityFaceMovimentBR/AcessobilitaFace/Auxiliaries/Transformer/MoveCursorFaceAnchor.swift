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
  private var toleranceX: CGFloat = 0.1
  private var toleranceY: CGFloat = 0.1
  private let valueMoviment: CGFloat
  // MARK: - Life Cicle

  init(valueMoviment: CGFloat) {
    self.valueMoviment = valueMoviment
  }

  // MARK: - Private Method

  private func verifyIsInitial(withPoint point: CGPoint) {
    if isInitial {
      lastFacePosition = point
      isInitial = false
    }
  }
  private func verifyDirectionMoveDiagonal(withPoint point: CGPoint) -> DirectionMove {
    if point.x > 0 {
      if point.y > 0 {
        return .topRightDiagonal
      } else {
        return .bottomRightDiagonal
      }
    } else {
      if point.y > 0 {
        return .topLeftDiagonal
      } else {
        return .bottomLeftDiagonal
      }
    }
  }

  private func verifyDirectionMove(withPoint point: CGPoint) -> DirectionMove {
    if abs((abs(point.x) - abs(lastFacePosition.x))) <= 0.005 {
      return .stop
    }

    if point.x >= 0 {
      if abs(abs(point.x) - abs(lastFacePosition.x)) > 0 {
        return .right
      } else {
        return .left
      }
    } else {
      if abs(point.x) - abs(lastFacePosition.x) > 0 {
        return .right
      } else {
        return .left
      }

    }
  }

  private func verifyIsStopFace(withPoint point: CGPoint) -> Bool {
    let stopX = (abs(point.x - lastPosition.x) > toleranceX)
    let stopY = (abs(point.y - lastPosition.y) > toleranceY)
    return (stopX && stopY)
  }
  
}

// MARK: - Extensions

extension MoveCursorFaceAnchor: MoveCursorProtocol, MoveCursorUtilsProtocol {
  func set(initialPosition initial: CGPoint) {
    lastPosition = initial
  }

  func getNextPosition(withPoint point: CGPoint) -> CGPoint {
    var newPositionCursor = CGPoint.zero
    
    verifyIsInitial(withPoint: point)

      switch verifyDirectionMove(withPoint: point) {
      case .left:
        newPositionCursor.x = lastPosition.x - valueMoviment
        newPositionCursor.y = lastPosition.y
      case .right:
        newPositionCursor.x = lastPosition.x + valueMoviment
        newPositionCursor.y = lastPosition.y
      default:
        newPositionCursor = lastPosition
    }

    if newPositionCursor.x < 0 || newPositionCursor.x > Constants.Screen.width {
      newPositionCursor = lastPosition
    }
    lastPosition = newPositionCursor
    lastFacePosition = point
    return newPositionCursor
  }
}
