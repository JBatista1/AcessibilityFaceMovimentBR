//
//  Position.swift
//  AcessibilityFaceMovimentBR
//
//  Created by Joao Batista on 10/02/21.
//  Copyright © 2021 Joao Batista. All rights reserved.
//

import UIKit

class Position {

  private let views: [UIView]
  private var absolutePosition: [CGRect] = []

  init(views: [UIView]) {
    self.views = views
    getAbsolutePositionViews()
  }

  func getViewSelectedBased(thePoint point: CGPoint) -> Int? {
    for index in 0..<views.count {
      if verify(withPoint: point, insideInFrame: absolutePosition[index]) {
        return index
      }
    }
    return nil
  }

  func verify(withPoint point: CGPoint, insideInFrame frame: CGRect) -> Bool {
    if point.x > frame.minX && point.x < frame.maxX {
      if point.y > frame.minY && point.y < frame.maxY {
        return true
      }
    }
    return false
  }

  func getAbsolutePositionViews() {
    for view in views {
      absolutePosition.append(view.absoluteValueToFrame())
    }
  }
}
