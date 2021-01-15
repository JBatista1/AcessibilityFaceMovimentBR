//
//  CGFloatExtension.swift
//  AcessibilityFaceMovimentBR
//
//  Created by Joao Batista on 14/01/21.
//  Copyright © 2021 Joao Batista. All rights reserved.
//

import UIKit

extension CGFloat {

  func truncate(withDecimalplaces places: Int) -> CGFloat {
    var truncateValue = (self * CGFloat(places))
    truncateValue = CGFloat(truncateValue / CGFloat(places))
    return truncateValue
  }
}
