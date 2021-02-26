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
