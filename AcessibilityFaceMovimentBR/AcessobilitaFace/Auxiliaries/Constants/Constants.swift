//
//  Constants.swift
//  AcessibilityFaceMovimentBR
//
//  Created by Joao Batista on 09/01/21.
//  Copyright © 2021 Joao Batista. All rights reserved.
//

import Foundation
import UIKit

enum Constants {

  enum Screen {
    static let heigh = UIScreen.main.bounds.height
    static let width = UIScreen.main.bounds.width
    static let center = CGPoint(x: Screen.width / 2, y: Screen.heigh / 2)
  }
  enum Cursor {
    static let heigh: CGFloat = 30
    static let width: CGFloat = 30
    static let x = CGFloat(Screen.center.x - (Cursor.heigh / 2))
    static let y = CGFloat(Screen.center.y - (Cursor.width / 2))
  }

}
