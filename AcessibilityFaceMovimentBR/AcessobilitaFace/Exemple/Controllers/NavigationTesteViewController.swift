//
//  NavigationTesteViewController.swift
//  AcessibilityFaceMovimentBR
//
//  Created by Joao Batista on 13/02/21.
//  Copyright © 2021 Joao Batista. All rights reserved.
//

import UIKit

class NavigationTesteViewController: AccessibilityFaceAnchor {

  @IBOutlet weak var nextButton: UIButton!
  @IBOutlet weak var bookImageView: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    action.setTypeStartAction(withType: .eyeRight)
    action.set(viewsAction: createViewAction())
    addActionUIImageView()
  }

  private func addActionUIImageView() {
    let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
    bookImageView.addGestureRecognizer(tap)
  }

  func createViewAction() -> [ViewAction] {
    let viewsAction: [ViewAction] = [ViewAction(view: nextButton, selector: #selector(tappedNextScreen(_:))),
                                     ViewAction(view: bookImageView, selector: #selector(handleTap(_:)))]
    return getViewsActionWithTabBar(viewsAction: viewsAction)
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
