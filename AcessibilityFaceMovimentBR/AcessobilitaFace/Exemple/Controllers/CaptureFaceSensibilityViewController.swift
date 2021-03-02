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

  private var arrayLimited: [Direction] = [.top, .botton, .left, .right]
  private var faceSensitivity = FaceSensitivity.getDefault()

  private enum Strings {
    static let detectando = "Detectando..."
    static let processando = "Capturando.."
    static let iniciar = "Iniciar Captura"
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    sensibilityDelegate = self
//    nextflowButton.isHidden = true
  }

  @IBAction func tapAction(_ sender: Any) {
    guard let actualDectection = arrayLimited.first else {return}
    initialCapture(withDirection: actualDectection.direction)
    captureButton.setTitle(Strings.detectando, for: .normal)
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let barViewControllers = segue.destination as? UITabBarController,
      let destinationViewController = barViewControllers.viewControllers![0] as? ViewController {
      destinationViewController.set(faceSensitivity: faceSensitivity)
    }
  }
}

extension CaptureFaceSensibilityViewController: GetSensitivityProtocol {

  func startCaptura() {
    DispatchQueue.main.async { // Correct
      self.captureButton.setTitle(Strings.processando, for: .normal)
    }
  }

  func returnCapture(theValue value: CGFloat) {
    DispatchQueue.main.async { // Correct
      self.captureButton.setTitle(Strings.iniciar, for: .normal)
      guard let actualDectection = self.arrayLimited.first else {return}
      switch actualDectection {
      case .top:
        self.faceSensitivity.limitedTopX = value
        self.titleLabel.text = "Mova a cabeça para a Baixo e clique em iniciar"
      case .botton:
        self.faceSensitivity.limitedBottonX = value
        self.titleLabel.text = "Mova a cabeça para a Direita e clique em iniciar"
      case .left:
        self.faceSensitivity.limitedLeftY = value
        self.titleLabel.text = "Mova a cabeça para a Esquerda e clique em iniciar"
      case .right:
        self.faceSensitivity.limitedRightY = value
        self.captureButton.isHidden = true
        self.nextflowButton.isHidden = false
      }
      self.arrayLimited.removeFirst()
      guard let nextDectection = self.arrayLimited.first else {return}
      self.arrowImage.image = nextDectection.image
    }
  }
}
