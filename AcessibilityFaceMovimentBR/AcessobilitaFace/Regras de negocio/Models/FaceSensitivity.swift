//
//  FaceSensitivity.swift
//  AcessibilityFaceMovimentBR
//
//  Created by Joao Batista on 28/02/21.
//  Copyright © 2021 Joao Batista. All rights reserved.
//

import UIKit

public struct FaceSensitivity {

  var limitedTopX: CGFloat
  var limitedBottonX: CGFloat
  var limitedLeftY: CGFloat
  var limitedRightY: CGFloat

  public init(limitedTopX: CGFloat, limitedBottonX: CGFloat, limitedLeftY: CGFloat, limitedRightY: CGFloat) {
    self.limitedTopX = limitedTopX
    self.limitedBottonX = limitedBottonX
    self.limitedLeftY = limitedLeftY
    self.limitedRightY = limitedRightY
  }

  static func getDefault() -> FaceSensitivity {
    return FaceSensitivity(limitedTopX: ValuesConstants.limitedX,
                           limitedBottonX: -ValuesConstants.limitedX,
                           limitedLeftY: ValuesConstants.limitedY,
                           limitedRightY: -ValuesConstants.limitedY)
  }

  func getLimitedX() -> CGFloat {
    return abs(limitedTopX) + abs(limitedBottonX)
  }
  
  func getLimitedY() -> CGFloat {
    return abs(limitedLeftY) + abs(limitedRightY)
  }
  
}
