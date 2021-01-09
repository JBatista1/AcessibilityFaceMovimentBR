//
//  AccessibilityFaceAnchor.swift
//  AcessibilityFaceMovimentBR
//
//  Created by Joao Batista on 07/01/21.
//  Copyright © 2021 Joao Batista. All rights reserved.
//

import UIKit
import ARKit

open class AccessibilityFaceAnchor: UIViewController {

  // MARK: - Private property
  private let sceneView = ARSCNView(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
  private let cursor = UIImageView(frame: CGRect(x: Constants.Cursor.x, y: Constants.Cursor.y, width: Constants.Cursor.width, height: Constants.Cursor.heigh))
  
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

  // MARK: - Class Methods

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
    view.addSubview(cursor)
    cursor.image = Asset.cursorDefault.image
    cursor.backgroundColor = .red
  }
}

// MARK: - Extension AR

extension AccessibilityFaceAnchor: ARSCNViewDelegate, ARSessionDelegate {

  public func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
    print(node.eulerAngles.x)
  }
}
