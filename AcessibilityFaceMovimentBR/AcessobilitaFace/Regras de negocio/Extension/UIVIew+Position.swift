//
//  UIVIew+Position.swift
//  Commons
//
//  Created by Joao Batista on 20/10/20.
//  Copyright © 2020 Joao Batista. All rights reserved.
//

import UIKit

extension UIView {

  func absoluteValueToPositionCenter() -> CGPoint {
    let rootView = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
    guard let absoluteCenter  = self.superview?.convert(self.center, to: rootView) else { return CGPoint(x: 0, y: 0)}
    return absoluteCenter
  }

  func absoluteValueToFrame() -> CGRect {
    if let baseWindow = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first {
      return returnAbsoluteValue(basedInWindows: baseWindow)
    }

    if let alternativeWindow = UIApplication.shared.windows.first {
       return returnAbsoluteValue(basedInWindows: alternativeWindow)
    }

    return CGRect(x: 0, y: 0, width: 0, height: 0)
  }
  private func returnAbsoluteValue(basedInWindows windows: UIWindow) -> CGRect {
    guard let absoluteframe = self.superview?.convert(self.frame, to: windows) else { return CGRect(x: 0, y: 0, width: 0, height: 0)}
    return absoluteframe
  }

  func getViewAcessibility(WithType type: AccessibilityUIType) -> UIView? {
    for view in self.subviews where view.accessibilityIdentifier == type.identifier {
      return view
    }
    return nil
  }
}
