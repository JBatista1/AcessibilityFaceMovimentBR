//
//  ActionInView.swift
//  AcessibilityFaceMovimentBR
//
//  Created by Joao Batista on 07/02/21.
//  Copyright © 2021 Joao Batista. All rights reserved.
//

import UIKit

class ActionInView: NSObject {

  private var viewsAction: [ViewAction] = []
  private var typeStartAction: TypeStartAction
  private var target: UIViewController
  private var position: Position?
  private var pointView: CGPoint = .zero
  private var manageCase = ManagesSpecialCases()

  required init(typeStartAction: TypeStartAction = .tongue, target: UIViewController) {
    self.typeStartAction = typeStartAction
    self.target = target
  }

  // MARK: - Private Method

  private func calledSelector(inViewAction viewAction: ViewAction) {
    if let identifier = viewAction.view.accessibilityIdentifier {
      calledSpecialTarge(withIndentifier: identifier, inViewAction: viewAction)
    } else {
      self.target.perform(viewAction.selector)
    }
  }

  private func calledSpecialTarge(withIndentifier identifier: String, inViewAction viewAction: ViewAction) {

    switch identifier {
    case AccessibilityUIType.uiButton.identifier,
         AccessibilityUIType.uiImageView.identifier:
      self.target.perform(viewAction.selector, with: identifier)

    case AccessibilityUIType.uiTableView.identifier:
      let indexPath = manageCase.getIndexPathTheUICollectionView(InView: viewAction.view, andPoint: pointView)
      self.target.perform(viewAction.selector, with: indexPath)

    case AccessibilityUIType.uiCollectionView.identifier:
      let indexPath = manageCase.getIndexPathTheUICollectionView(InView: viewAction.view, andPoint: pointView)
      self.target.perform(viewAction.selector, with: indexPath)

    default:
      self.target.perform(viewAction.selector)
    }
  }

  private func verify(theEyeClose eyeClose: CGFloat, andEyeOpen eyeOpen: CGFloat) -> Bool {
    return eyeClose >= ValuesConstants.closeEye && eyeOpen <= ValuesConstants.openEye
  }
  
}

// MARK: - Extension

extension ActionInView: ActionProtocol {

  func verifyAction(withValueEyeRight eyeRight: CGFloat, theEyeLeft eyeLeft: CGFloat, andTongueValue tongue: CGFloat) -> Bool {
    switch typeStartAction {
    case .eyeLeft:
      return verify(theEyeClose: eyeLeft, andEyeOpen: eyeRight)
    case .eyeRight:
      return verify(theEyeClose: eyeRight, andEyeOpen: eyeLeft)
    case .tongue:
      return tongue >= ValuesConstants.tongue
    }
  }

  func getViewForAction(withPoint point: CGPoint) {
    pointView = point
    if let index = position?.getViewSelectedBased(thePoint: point) {
      let viewAction = viewsAction[index]
      DispatchQueue.main.async {
        self.calledSelector(inViewAction: viewAction)
      }
    }
  }

  func setTypeStartAction(withType type: TypeStartAction) {
    self.typeStartAction = type
  }

  func set(viewsAction: [ViewAction]) {
    var views = [UIView]()

    var newViewsAction = manageCase.inserTabBarViews(inViewsAction: viewsAction)
    newViewsAction = manageCase.insertAccessibilityIdentifier(inViewsAction: newViewsAction)

    for viewAction in newViewsAction {
      views.append(viewAction.view)
    }

    position = Position(views: views)
    self.viewsAction = newViewsAction
  }
}
