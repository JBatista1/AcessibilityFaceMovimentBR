//
//  AcessibilityViewController.swift
//  AcessibilityFaceMovimentBR
//
//  Created by Joao Batista on 13/02/21.
//  Copyright © 2021 Joao Batista. All rights reserved.
//

import UIKit

open class AcessibilityViewController: UIViewController {

  // MARK: Delegates

  weak var delegateTabBar: TabBarSelectedProtocol?
  weak var delegateNavigationBar: NavigationBackButtonProtocol?
  weak var delegateTableView: TableViewSelectedProtocol?

  // MARK: - Public Property
  let cursor = UIImageView(frame: CGRect(x: Constants.Cursor.x, y: Constants.Cursor.y, width: Constants.Cursor.width, height: Constants.Cursor.heigh))
  var action: ActionProtocol!

  public override func viewDidLoad() {
    super.viewDidLoad()
    action = ActionInView(target: self)
    insertCursor()
  }

  // MARK: - Public Class Methods

  func getViewsActionWithTabBar(viewsAction: [ViewAction]) -> [ViewAction] {
    var newViewActions = viewsAction
    if let tabBar = self.getTabBar() {
      newViewActions.append(ViewAction(view: tabBar, selector: #selector(selectedTabBar(withIndex:))))
    }
    return newViewActions
  }

  func getViewsActionBackNavigationBar(viewsAction: [ViewAction]) -> [ViewAction] {
    return viewsAction
  }

  // MARK: - Private Class Methods

  @objc private func selectedTabBar(withIndex index: String) {
    if let selectedIndex = Int(index) {
      delegateTabBar?.tabBar(isSelectedIndex: selectedIndex)
    }
  }

  @objc private func selectedBackNavigationBar() {
    delegateNavigationBar?.actionNavigationBack()
  }
  
  @objc private func selectedCell(withIndex index: IndexPath) {
    
  }

  private func insertCursor() {
    guard let windows = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else {
      view.addSubview(cursor)
      return
    }
    windows.addSubview(cursor)
    cursor.image = Asset.cursorDefault.image
  }
}
