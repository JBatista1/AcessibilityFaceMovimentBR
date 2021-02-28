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
  var limitedTopY: CGFloat
  var limitedBottonY: CGFloat

  public init(limitedTopX: CGFloat, limitedBottonX: CGFloat, limitedTopY: CGFloat, limitedBottonY: CGFloat) {
    self.limitedTopX = limitedTopX
    self.limitedBottonX = limitedBottonX
    self.limitedTopY = limitedTopY
    self.limitedBottonY = limitedBottonY
  }
  static func getDefault() -> FaceSensitivity {
    return FaceSensitivity(limitedTopX: ValuesConstants.limitedX,
                           limitedBottonX: -ValuesConstants.limitedX,
                           limitedTopY: ValuesConstants.limitedY,
                           limitedBottonY: -ValuesConstants.limitedY)
  }

  func getLimitedX() -> CGFloat {
    return abs(limitedTopX) + abs(limitedBottonX)
  }
  
  func getLimitedY() -> CGFloat {
    return abs(limitedTopY) + abs(limitedBottonY)
  }
  
}
