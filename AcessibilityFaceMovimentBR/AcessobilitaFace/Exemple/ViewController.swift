//
//  ViewController.swift
//  AcessibilityFaceMovimentBR
//
//  Created by Joao Batista on 04/01/21.
//  Copyright © 2021 Joao Batista. All rights reserved.
//

import UIKit

class ViewController: AccessibilityFaceAnchor {

  // MARK: - Outlets

  @IBOutlet weak var feedbackLabel: UILabel!
  
  // Views I
  @IBOutlet weak var viewOne: UIButton!
  @IBOutlet weak var viewTwo: UIButton!
  @IBOutlet weak var viewThree: UIButton!
  @IBOutlet weak var viewFour: UIButton!
  @IBOutlet weak var viewFive: UIButton!
  @IBOutlet weak var viewSix: UIButton!
  @IBOutlet weak var viewSeven: UIButton!
  @IBOutlet weak var viewEight: UIButton!

  override func viewDidLoad() {
    super.viewDidLoad()
    action = ActionInView(superView: view, typeStartAction: .tongue, target: self)
    action.set(viewsAction: createViewAction())
  }

  func createViewAction() -> [ViewAction] {
     let selectorsTabbar = [#selector(ViewController.firstTabBarButton),#selector(ViewController.secondTabBarButton),#selector(ViewController.thirdTabBarButton)]
    var viewsTabbar = [ViewAction]()

    if let views = tabBarController?.tabBar.subviews {
      var index = 0
      for view in views {
        if view.isKind(of: NSClassFromString("UITabBarButton")!) {
          viewsTabbar.append(ViewAction(view: view, selector: selectorsTabbar[index]))
          index += 1
        }
      }
    }

    var viewsAction = [ViewAction(view: viewOne, selector: #selector(ViewController.actionOne)),
                       ViewAction(view: viewTwo, selector: #selector(actionTwo)),
                       ViewAction(view: viewThree, selector: #selector(actionThree)),
                       ViewAction(view: viewFour, selector: #selector(actionFour)),
                       ViewAction(view: viewFive, selector: #selector(actionFive)),
                       ViewAction(view: viewSix, selector: #selector(actionSix)),
                       ViewAction(view: viewSeven, selector: #selector(actionSeven)),
                       ViewAction(view: viewEight, selector: #selector(actionEight))]
    viewsAction.append(contentsOf: viewsTabbar)
    return viewsAction
  }

  @objc func actionOne() {
    feedbackLabel.text = "Lilaz"
  }

  @objc func actionTwo() {
    feedbackLabel.text = "Vermelho"
  }

  @objc func actionThree() {
    feedbackLabel.text = "Laranja"
  }

  @objc func actionFour() {
    feedbackLabel.text = "Azul marinho"
  }

  @objc func actionFive() {
    feedbackLabel.text = "amarelo"
  }

  @objc func actionSix() {
    feedbackLabel.text = "Verde"
  }

  @objc func actionSeven() {
    feedbackLabel.text = "Rosa"
  }

  @objc func actionEight() {
    feedbackLabel.text = "Roxo"
  }

  @objc func firstTabBarButton() {
     tabBarController?.selectedIndex = 0
  }

  @objc func secondTabBarButton() {
     tabBarController?.selectedIndex = 1
  }

  @objc func thirdTabBarButton() {
     tabBarController?.selectedIndex = 2
  }
}
