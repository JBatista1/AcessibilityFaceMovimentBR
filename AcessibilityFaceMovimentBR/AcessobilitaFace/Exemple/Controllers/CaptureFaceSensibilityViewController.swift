//
//  CaptureFaceSensibilityViewController.swift
//  AcessibilityFaceMovimentBR
//
//  Created by Joao Batista on 01/03/21.
//  Copyright © 2021 Joao Batista. All rights reserved.
//

import UIKit

class CaptureFaceSensibilityViewController: AcessibilityGetSensitivityViewController {

  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var arrowImage: UIImageView!
  @IBOutlet weak var nextflowButton: UIButton!
  @IBOutlet weak var captureButton: UIButton!

  override func viewDidLoad() {
    super.viewDidLoad()
    sensibilityDelegate = self
    nextflowButton.isHidden = true
    
  }

  @IBAction func tapAction(_ sender: Any) {
    initialCapture(withDirection: .axisX)
  }

  func GoToTest() {
    if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SuccessViewController") as? SuccessViewController {
      if let navigator = navigationController {
        navigator.pushViewController(viewController, animated: true)
      }
    }
    
  }
}

extension CaptureFaceSensibilityViewController: GetSensitivityProtocol {

  func startCaptura() {

  }

  func returnCapture(theValue value: CGFloat) {
    print("Finish \(value)")
  }
}
