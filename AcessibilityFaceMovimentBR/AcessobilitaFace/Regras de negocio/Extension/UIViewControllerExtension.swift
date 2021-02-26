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
}
