//
//  ActionInView.swift
//  AcessibilityFaceMovimentBR
//
//  Created by Joao Batista on 07/02/21.
//  Copyright © 2021 Joao Batista. All rights reserved.
//

import UIKit

class ActionInView: NSObject, ActionProtocol {

  private var superView: UIView
  private var viewsAction: [ViewAction] = []
  private var typeStartAction: TypeStartAction
  private var isInAction: Bool = false
  private var target: UIViewController
  private var position: Position!

  private enum Constants {
    static let closeEye: CGFloat = 0.8
    static let openEye: CGFloat = 0.3
    static let tongue: CGFloat = 0.8
  }

  required init(superView: UIView, typeStartAction: TypeStartAction, target: UIViewController) {
    self.superView = superView
    self.typeStartAction = typeStartAction
    self.target = target

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
    if let index = position.getViewSelectedBased(thePoint: point) {
      print(index)
      DispatchQueue.main.async {
        self.target.perform(self.viewsAction[index].selector)
      }
    }
  }
  
  func setTypeStartAction(withType type: TypeStartAction) {
    self.typeStartAction = type
  }

  func set(viewsAction: [ViewAction]) {
    var views = [UIView]()
    for viewAction in viewsAction {
      views.append(viewAction.view)
    }
    position = Position(views: views)
    self.viewsAction = viewsAction
  }

  private func verify(theEyeClose eyeClose: CGFloat, andEyeOpen eyeOpen: CGFloat) -> Bool {
    return eyeClose >= Constants.closeEye && eyeOpen <= Constants.openEye
  }
}
