//
//  MoveCursorUtilsProtocol.swift
//  AcessibilityFaceMovimentBR
//
//  Created by Joao Batista on 11/01/21.
//  Copyright © 2021 Joao Batista. All rights reserved.
//

import UIKit

protocol MoveCursorUtilsProtocol {
   func itsInsideInScreen(thePoint point: CGPoint, AndLastPoint lastPoint: CGPoint) -> CGPoint
}

extension MoveCursorUtilsProtocol {
  func itsInsideInScreen(thePoint point: CGPoint, AndLastPoint lastPoint: CGPoint) -> CGPoint {

    var newPosition = CGPoint.zero
    let limitedScreenY = verifyAxis(WithValue: point.y, andLimited: Constants.Screen.heigh)
    let limitedScreenX = verifyAxis(WithValue: point.y, andLimited: Constants.Screen.width)
    newPosition.x =  getPosition(withPoint: point.x, thelastPoint: lastPoint.x, andLimitedScreen: limitedScreenX)
    newPosition.y =  getPosition(withPoint: point.y, thelastPoint: lastPoint.y, andLimitedScreen: limitedScreenY)

    return newPosition
  }

  private func verifyAxis(WithValue value: CGFloat, andLimited limited: CGFloat) -> LimitedScreen {
    switch value {
    case ..<0:
      return .less
    case ..<limited:
      return .inside
    default:
      return .more
    }
  }

  private func getPosition(withPoint point: CGFloat, thelastPoint lastPoint: CGFloat, andLimitedScreen limited: LimitedScreen) -> CGFloat {
    switch limited {
    case .inside:
      return point
    case .more, .less:
      return lastPoint
    }
  }
}
