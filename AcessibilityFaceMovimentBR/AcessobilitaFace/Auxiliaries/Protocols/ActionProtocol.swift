//
//  ActionProtocol.swift
//  AcessibilityFaceMovimentBR
//
//  Created by Joao Batista on 07/02/21.
//  Copyright © 2021 Joao Batista. All rights reserved.
//

import UIKit

protocol ActionProtocol {
  init(viewsAction: [ViewAction], superView: UIView, typeStartAction: TypeStartAction)
  func verifyAction(withValue eyeRight: CGFloat, theEyeLeft eyeLeft: CGFloat, andTongueValue tongue: CGFloat) -> Bool
  func getViewForAction(withPoint point: CGPoint)
  func setTypeStartAction(withType type: TypeStartAction)
}
