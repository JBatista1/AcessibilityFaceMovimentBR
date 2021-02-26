//
//  UICollectionViewExtension.swift
//  AcessibilityFaceMovimentBR
//
//  Created by Joao Batista on 26/02/21.
//  Copyright © 2021 Joao Batista. All rights reserved.
//

import UIKit

extension UICollectionView {

  func getCell() -> [UICollectionViewCell] {
    var cells = [UICollectionViewCell]()
    for section in 0...(self.numberOfSections-1) {
      for item in 0...(self.self.numberOfItems(inSection: section)-1) {
        if let cell = self.cellForItem(at: IndexPath(row: item, section: section)) {
          cells.append(cell)
          cell.accessibilityElements = [IndexPath(item: item, section: section)]
        }
      }
    }
    return cells
  }
}

