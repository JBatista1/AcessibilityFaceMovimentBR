//
//  UIViewControllerExtension.swift
//  AcessibilityFaceMovimentBR
//
//  Created by Joao Batista on 13/02/21.
//  Copyright © 2021 Joao Batista. All rights reserved.
//

import UIKit

extension UIViewController {

  func getTabBar() -> UITabBar? {
    guard let tabBar = tabBarController?.tabBar else {
      return nil
    }
    return tabBar
  }

  func getNavigationBar() -> UINavigationBar? {
    guard let navBar = navigationController?.navigationBar else {
      return nil
    }
    return navBar
  }

  func getNavigationBackButton() -> UIView? {
    guard let navBar = navigationController?.navigationBar else {
      return nil
    }
    if navBar.subviews.count >= 2 {
      let views = navBar.subviews[1]
      if views.subviews.count >= 1 && views.subviews.count >= 2 {
        return views.subviews[1]
      }
    }
    return nil
  }
}
