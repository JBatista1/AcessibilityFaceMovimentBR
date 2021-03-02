//
//  AcessibilityViewController.swift
//  AcessibilityFaceMovimentBR
//
//  Created by Joao Batista on 13/02/21.
//  Copyright © 2021 Joao Batista. All rights reserved.
//

import UIKit
import SpriteKit

open class AcessibilityViewController: UIViewController {

  // MARK: Delegates

  weak var delegateTabBar: TabBarSelectedProtocol?
  weak var delegateNavigationBar: NavigationBackButtonProtocol?
  weak var delegateCellView: CellViewSelectedProtocol?

  // MARK: - Public Property

  var cursor = SKSpriteNode(imageNamed: "cursorDefault")
  var action: ActionProtocol!
  var skView = SKView()
  let scene = SKScene(size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))

  public override func viewDidLoad() {
    super.viewDidLoad()
    action = ActionInView(target: self)
    setupCursor()
    insertCursor()
    skView.showsFPS = true
    skView.showsNodeCount = true
    skView.ignoresSiblingOrder = true
    skView.presentScene(scene)
    skView.frame.size = scene.size
    skView.backgroundColor = .clear
    scene.backgroundColor = .clear
    cursor.size = CGSize(width: Cursor.width, height: Cursor.heigh)
  }

  open override func didMove(toParent parent: UIViewController?) {
    let point = CGPoint(x: Cursor.x, y: Cursor.y)
    let actionMove = SKAction.move(to: point, duration: 0.15)
    cursor.run(actionMove)
    scene.addChild(cursor)
  }

  // MARK: - Private Class Methods

  private func setupCursor() {
    skView.accessibilityIdentifier = AccessibilityUIType.uiCursor.identifier
  }

  open override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    tabBarController?.tabBar.invalidateIntrinsicContentSize()
  }

  private func insertCursor() {
    if let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first, (getCursor(inWindows: window) == nil) {
      window.addSubview(skView)
      return
    }

    if let window = UIApplication.shared.windows.first, (getCursor(inWindows: window) == nil) {
      window.makeKey()
      window.addSubview(skView)
      return
    }
  }

  private func getCursor(inWindows windows: UIWindow) -> SKView? {
    if let cursor = windows.getViewAcessibility(WithType: .uiCursor) as? SKView {
      self.skView = cursor
      return self.skView
    }
    return nil
  }
}

// MARK: - Selector for delegates

extension AcessibilityViewController {

  @objc private func selectedTabBar(withIndex index: String) {
    guard let selectedIndex = Int(index) else { return }
    delegateTabBar?.tabBar(isSelectedIndex: selectedIndex)
  }

  @objc private func selectedBackNavigationBar() {
    delegateNavigationBar?.actionNavigationBack()
  }

  @objc func selectedCell(_ sender: Any? = nil) {
    guard let index = sender as? IndexPath else { return }
    delegateCellView?.cellSelected(withIndex: index)
  }
}

// MARK: - GetNavigation Controll Actions

extension AcessibilityViewController {

  func getViewsActionWithTabBar() -> [ViewAction] {
    if let tabBar = self.getTabBar() {
      return [ViewAction(view: tabBar, selector: #selector(selectedTabBar(withIndex:)))]
    }
    return []
  }

  func getViewsActionBackNavigationBar() -> [ViewAction] {
    if let navBar = self.getNavigationBackButton() {
       return [ViewAction(view: navBar, selector: #selector(selectedBackNavigationBar))]
    }
    return []
  }

  func getViewActionNavigationAndTabBar() -> [ViewAction] {
    var newViewActions = [ViewAction]()
    newViewActions.append(contentsOf: getViewsActionWithTabBar())
    newViewActions.append(contentsOf: getViewsActionBackNavigationBar())
    return newViewActions
  }
}
