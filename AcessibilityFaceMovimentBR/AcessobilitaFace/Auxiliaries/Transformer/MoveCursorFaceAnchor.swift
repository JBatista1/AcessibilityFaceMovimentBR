//
//  MoveCursorFaceAnchor.swift
//  AcessibilityFaceMovimentBR
//
//  Created by Joao Batista on 11/01/21.
//  Copyright © 2021 Joao Batista. All rights reserved.
//

import UIKit

final class MoveCursorFaceAnchor {
  
  // MARK: - Life Cicle

  init() {

  }
  // MARK: - Private Method
  
}
// MARK: - Extensions

extension MoveCursorFaceAnchor: MoveCursorProtocol {

  func getNextPosition(withPoint point: CGPoint) -> CGPoint {
    return CGPoint(x: 0, y: 0)
  }
}
