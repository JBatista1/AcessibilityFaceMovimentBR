//
//  Constants.swift
//  AcessibilityFaceMovimentBR
//
//  Created by Joao Batista on 09/01/21.
//  Copyright © 2021 Joao Batista. All rights reserved.
//

import UIKit

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

enum ValuesConstants {
  static let closeEye: CGFloat = 0.6
  static let openEye: CGFloat = 0.3
  static let tongue: CGFloat = 0.6
  static let indexPathError = IndexPath(row: -1, section: -1)
  static let tabBarIndexError: Int = -1
  static let cooldown: Int = 3
}

internal enum AccessibilityUIType: String {

  case uiButton
  case uiImageView
  case uiTableView
  case uiCollectionView
  case uiCursor
  case uiTabBar
  case unknown

  var identifier: String {
    switch self {
    case .uiButton:
      return "UIButton"
    case .uiImageView:
      return "UIImageView"
    case .uiTableView:
      return "UITableView"
    case .uiCollectionView:
      return "UICollectionView"
    case .uiCursor:
      return "UICursor"
    case .uiTabBar:
      return "UITabBar"
    case .unknown:
      return "UIUNKNOWN"

    }
  }
}
