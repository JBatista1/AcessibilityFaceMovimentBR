//
//  AccessibilityFaceAnchor.swift
//  AcessibilityFaceMovimentBR
//
//  Created by Joao Batista on 07/01/21.
//  Copyright © 2021 Joao Batista. All rights reserved.
//

import UIKit
import ARKit

open class AccessibilityFaceAnchorViewController: AcessibilityViewController {

  // MARK: - Private Property
  
  private let sceneView = ARSCNView(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
  private let moveCursor: MoveCursorProtocol = MoveCursorFaceAnchor()
  private var isShow = true
  // MARK: - Life cicle

  open override func viewDidLoad() {
    super.viewDidLoad()
    setupSceneView()
    setupViews()
  }

  open override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    UIApplication.shared.isIdleTimerDisabled = true
    resetTracking()
  }

  open override func viewDidDisappear(_ animated: Bool) {
    sceneView.session.pause()
  }

  // MARK: - Private Class Methods

  private func resetTracking() {
    guard ARFaceTrackingConfiguration.isSupported else {return}
    let configuration = ARFaceTrackingConfiguration()
    configuration.maximumNumberOfTrackedFaces = 1
    sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
  }

  private func setupSceneView() {
    sceneView.delegate = self
    sceneView.session.delegate = self
    sceneView.isHidden = true
  }

  private func setupViews() {
    view.addSubview(sceneView)
  }

  private func animateCursor(toNextPoint nextPoint: CGPoint) {
    DispatchQueue.main.async {
      UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 6, initialSpringVelocity: 0.2, options: [.curveLinear, .preferredFramesPerSecond60], animations: {
        self.cursor.center = nextPoint
      }, completion: nil)
    }
  }

  private func verifyAction(withValueEyeRight eyeRight: CGFloat, theEyeLeft eyeLeft: CGFloat, tongueValue tongue: CGFloat, andPoint pointMouse: CGPoint) {
    if action.verifyAction(withValueEyeRight: eyeRight, theEyeLeft: eyeLeft, andTongueValue: tongue) {
      action.getViewForAction(withPoint: pointMouse)
    }
  }
}

// MARK: - Extension AR

extension AccessibilityFaceAnchorViewController: ARSCNViewDelegate, ARSessionDelegate {

  public func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {

    guard let faceAnchor = anchor as? ARFaceAnchor,
      let eyeRight = faceAnchor.blendShapes[.eyeBlinkLeft] as? CGFloat,
      let eyeLeft = faceAnchor.blendShapes[.eyeBlinkRight] as? CGFloat,
      let tongue = faceAnchor.blendShapes[.tongueOut] as? CGFloat else { return }

        let point = CGPoint(x: CGFloat(node.eulerAngles.y).truncate(), y: CGFloat(node.eulerAngles.x).truncate())
        let newPosition = self.moveCursor.getNextPosition(withPoint: point)
        self.verifyAction(withValueEyeRight: eyeRight, theEyeLeft: eyeLeft, tongueValue: tongue, andPoint: newPosition)
        self.animateCursor(toNextPoint: newPosition)
  }
}
