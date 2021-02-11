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
    print(viewOne.frame.minX)
    print(viewOne.frame.maxX)
    // Do any additional setup after loading the view.
  }

  func createViewAction() -> [ViewAction] {
    let viewsAction = [ViewAction(view: viewOne, selector: #selector(ViewController.actionOne)),
                       ViewAction(view: viewTwo, selector: #selector(actionTwo)),
                       ViewAction(view: viewThree, selector: #selector(actionThree)),
                       ViewAction(view: viewFour, selector: #selector(actionFour)),
                       ViewAction(view: viewFive, selector: #selector(actionFive)),
                       ViewAction(view: viewSix, selector: #selector(actionSix)),
                       ViewAction(view: viewSeven, selector: #selector(actionSeven)),
                       ViewAction(view: viewEight, selector: #selector(actionEight))]
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
}
