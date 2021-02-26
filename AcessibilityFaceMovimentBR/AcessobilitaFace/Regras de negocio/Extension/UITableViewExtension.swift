//
//  UITableViewExtension.swift
//  AcessibilityFaceMovimentBR
//
//  Created by Joao Batista on 25/02/21.
//  Copyright © 2021 Joao Batista. All rights reserved.
//

import UIKit

extension UITableView {

  func getCell() -> [UITableViewCell] {
    var cells = [UITableViewCell]()
    for section in 0...(self.numberOfSections-1) {
      for row in 0...(self.numberOfRows(inSection: section)-1) {
        if let cell = self.cellForRow(at: IndexPath(row: row, section: section)) {
          cells.append(cell)
          cell.accessibilityElements = [IndexPath(row: row, section: section)]
        }
      }
    }
    return cells
  }
}

extension UIScrollView {

  func getFormattedViews<T>(withType type: T) -> ([UIView]) {
    let views = formatViews(viewIsType: T.self)
    if views.count != 0 {
      return views
    }
    return []
  }

  private func formatViews<T>(viewIsType type: T) -> [UIView] {
    var views = [UIView]()
    for view in self.subviews where ((view as? T) != nil) {
      if let cell = view as? T, let cellViews = cell as? UIView {
        views.append(cellViews)
      }
    }
    return views
  }
}
