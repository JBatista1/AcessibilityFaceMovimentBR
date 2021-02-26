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

  private enum ValuesConstants {
    static let closeEye: CGFloat = 0.6
    static let openEye: CGFloat = 0.3
    static let tongue: CGFloat = 0.8
  }

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
    case Constants.AccessibilityUIType.uiButton.identifier,
         Constants.AccessibilityUIType.uiImageView.identifier:

      self.target.perform(viewAction.selector, with: identifier)

    case Constants.AccessibilityUIType.uiTableView.identifier:
      if let indexPath = getIndexPath(InView: viewAction.view) {
        self.target.perform(viewAction.selector, with: indexPath)
      } else {
        self.target.perform(viewAction.selector)
      }

    default:
      self.target.perform(viewAction.selector)
    }
  }

  func getIndexPath(InView view: UIView) -> IndexPath? {
    guard let tableView = view as? UITableView else {return nil}
    let views = tableView.getCell()
    let index = position?.getViewSelectedBased(thePoint: pointView, InTableViewCells: views)
    if let safeIndex = index, let cell = views[safeIndex] as? UITableViewCell, let indexPath = cell.accessibilityElements?.first as? IndexPath {
      return indexPath
    }
    return nil
  }
  private func inserTabBarViews(inViewsAction viewsAction: [ViewAction]) -> [ViewAction] {
    var newViewsActions = viewsAction
    var index = 0
    for viewAction in viewsAction {
      if let tabBar = viewAction.view as? UITabBar {
        newViewsActions.remove(at: index)
        newViewsActions.append(contentsOf: getTabBarViews(inTabBar: tabBar, andSelector: viewAction.selector))
      }
      index += 1
    }
    return newViewsActions
  }

  private func insertAccessibilityIdentifier(inViewsAction viewsAction: [ViewAction]) -> [ViewAction] {
    for viewAction in viewsAction {
      switch viewAction.view {
      case is UIButton:
        viewAction.view.accessibilityIdentifier = Constants.AccessibilityUIType.uiButton.identifier
      case is UIImageView:
        viewAction.view.accessibilityIdentifier = Constants.AccessibilityUIType.uiImageView.identifier
      case is UITableView:
        viewAction.view.accessibilityIdentifier = Constants.AccessibilityUIType.uiTableView.identifier
      default:
        viewAction.view.accessibilityIdentifier = Constants.AccessibilityUIType.unknown.identifier
      }
    }
    return viewsAction
  }
  
  private func getTabBarViews(inTabBar tabBar: UITabBar, andSelector selector: Selector ) -> [ViewAction] {
    var viewsTabbar = [ViewAction]()
    var index = 0
    for view in tabBar.subviews {
      if view.isKind(of: NSClassFromString("UITabBarButton")!) {
        view.accessibilityIdentifier = "\(index)"
        viewsTabbar.append(ViewAction(view: view, selector: selector))
        index += 1
      }
    }
    return viewsTabbar
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

    var newViewsAction = inserTabBarViews(inViewsAction: viewsAction)
    newViewsAction = insertAccessibilityIdentifier(inViewsAction: newViewsAction)

    for viewAction in newViewsAction {
      views.append(viewAction.view)
    }

    position = Position(views: views)
    self.viewsAction = newViewsAction
  }
}
