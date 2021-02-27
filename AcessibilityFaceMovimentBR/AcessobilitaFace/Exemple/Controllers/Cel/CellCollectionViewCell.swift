//
//  cellCollectionViewCell.swift
//  AcessibilityFaceMovimentBR
//
//  Created by Joao Batista on 26/02/21.
//  Copyright © 2021 Joao Batista. All rights reserved.
//

import UIKit

class CellCollectionViewCell: UICollectionViewCell {
    
  @IBOutlet weak var itemLabel: UILabel!

  func setup(numberItem item: Int) {
    itemLabel.text = "Item \(item)"
  }
}
