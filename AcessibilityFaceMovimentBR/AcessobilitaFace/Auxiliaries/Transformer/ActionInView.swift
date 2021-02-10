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
  private var viewsAction: [ViewAction] = []
  private var typeStartAction: TypeStartAction
  private var isInAction: Bool = false
  private enum Constants {
    static let closeEye: CGFloat = 0.8
    static let openEye: CGFloat = 0.6
    static let tongue: CGFloat = 0.9
  }

  required init(superView: UIView, typeStartAction: TypeStartAction) {
    self.superView = superView
    self.typeStartAction = typeStartAction
  }

  func verifyAction(withValueEyeRight eyeRight: CGFloat, theEyeLeft eyeLeft: CGFloat, andTongueValue tongue: CGFloat) -> Bool {
    switch typeStartAction {
    case .eyeLeft:
      return verify(theEyeClose: eyeLeft, andEyeOpen: eyeRight)
    case .eyeRight:
      return verify(theEyeClose: eyeRight, andEyeOpen: eyeLeft)
    case .tongue:
      return tongue >= Constants.tongue
    }
  }

  func getViewForAction(withPoint point: CGPoint) {
    print("teste")
  }
  
  func setTypeStartAction(withType type: TypeStartAction) {
    self.typeStartAction = type
  }

  private func verify(theEyeClose eyeClose: CGFloat, andEyeOpen eyeOpen: CGFloat) -> Bool {
    return eyeClose >= Constants.closeEye && eyeOpen <= Constants.openEye
  }
}
