//
//  ActionInView.swift
//  AcessibilityFaceMovimentBR
//
//  Created by Joao Batista on 07/02/21.
//  Copyright © 2021 Joao Batista. All rights reserved.
//

import UIKit

class ActionInView: ActionProtocol {

  private var superView: UIView
  private var viewsAction: [ViewAction]
  private var typeStartAction: TypeStartAction

  required init(viewsAction: [ViewAction], superView: UIView, typeStartAction: TypeStartAction) {
    self.viewsAction = viewsAction
    self.superView = superView
    self.typeStartAction = typeStartAction
  }

  func verifyAction(withValue eyeRight: CGFloat, theEyeLeft eyeLeft: CGFloat, andTongueValue tongue: CGFloat) -> Bool {
    return true
  }

  func getViewForAction(withPoint point: CGPoint) {

  }
  
  func setTypeStartAction(withType: TypeStartAction) {

  }
}
