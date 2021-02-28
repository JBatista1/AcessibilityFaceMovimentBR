//
//  NavigationTesteViewController.swift
//  AcessibilityFaceMovimentBR
//
//  Created by Joao Batista on 13/02/21.
//  Copyright © 2021 Joao Batista. All rights reserved.
//

import UIKit

class NavigationTesteViewController: AccessibilityFaceAnchorViewController {

  @IBOutlet weak var nextButton: UIButton!
  @IBOutlet weak var bookImageView: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    action.set(viewsAction: createViewAction())
    addActionUIImageView()
    delegateTabBar = self
  }

  private func addActionUIImageView() {
    let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
    bookImageView.addGestureRecognizer(tap)
  }

  func createViewAction() -> [ViewAction] {
    var viewsAction: [ViewAction] = [ViewAction(view: nextButton, selector: #selector(tappedNextScreen(_:))),
                                     ViewAction(view: bookImageView, selector: #selector(handleTap(_:)))]
    viewsAction.append(contentsOf: getViewsActionWithTabBar())
    return viewsAction
  }

  @IBAction func tappedNextScreen(_ sender: Any) {
    if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SuccessViewController") as? SuccessViewController {
      if let navigator = navigationController {
        navigator.pushViewController(viewController, animated: true)
      }
    }
  }

  @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
    bookImageView.image = UIImage.init(systemName: "book")
  }
}
extension NavigationTesteViewController: TabBarSelectedProtocol {
  func tabBar(isSelectedIndex index: Int) {
    tabBarController?.selectedIndex = index
  }
}
