//
//  AccessibilityFaceAnchor.swift
//  AcessibilityFaceMovimentBR
//
//  Created by Joao Batista on 07/01/21.
//  Copyright © 2021 Joao Batista. All rights reserved.
//

import UIKit
import ARKit
import Speech

open class AccessibilityFaceAnchorViewController: AcessibilityViewController {

  // MARK: - Private Property
  
  private let sceneView = ARSCNView(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
  private let moveCursor: MoveCursorProtocol = MoveCursorFaceAnchor()
  private var isShow = true

  let audioEngine = AVAudioEngine()
  let speechReconizer : SFSpeechRecognizer? = SFSpeechRecognizer(locale: Locale(identifier: "pt-BR"))
  let request = SFSpeechAudioBufferRecognitionRequest()
  var task : SFSpeechRecognitionTask!

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
    checkPermissions()
  }

  open override func viewDidDisappear(_ animated: Bool) {
    sceneView.session.pause()
  }

  public func set(faceSensitivity: FaceSensitivity) {
    moveCursor.set(faceSensitivity: faceSensitivity)
  }
  // MARK: - Private Class Methods

  private func resetTracking() {
    guard ARFaceTrackingConfiguration.isSupported else {return}
    let configuration = ARFaceTrackingConfiguration()
    configuration.maximumNumberOfTrackedFaces = 1
    sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
  }

  private func setupSceneView() {
    sceneView.delegate = self
    sceneView.session.delegate = self
    sceneView.isHidden = true
    sceneView.preferredFramesPerSecond = 45
  }

  private func setupViews() {
    view.addSubview(sceneView)
  }

  private func animateCursor(toNextPoint nextPoint: CGPoint) {
    let actionMove = SKAction.move(to: nextPoint, duration: 0.17)
    cursor.run(actionMove)
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
      let tongue = faceAnchor.blendShapes[.tongueOut] as? CGFloat else {
        return
    }

    let point = CGPoint(x: CGFloat(node.eulerAngles.y).truncate(), y: CGFloat(node.eulerAngles.x).truncate())
    let newPosition = self.moveCursor.getNextPosition(withPoint: point)
    self.verifyAction(withValueEyeRight: eyeRight, theEyeLeft: eyeLeft, tongueValue: tongue, andPoint: newPosition.screen)
    self.animateCursor(toNextPoint: newPosition.cursor)
  }
}

// Recongnizer

extension AccessibilityFaceAnchorViewController {
  //MOVER Para arquivo separado
  private func checkPermissions() {
    SFSpeechRecognizer.requestAuthorization { authStatus in
      DispatchQueue.main.async {
        switch authStatus {
        case .authorized:
          print("AQUI")
          break
        case .denied:
          // TODO: Implement.
          break
        case .restricted:
          // TODO: Implement.
          break
        case .notDetermined:
          // TODO: Implement.
          break
        @unknown default:
          fatalError()
        }
      }
    }
  }

  //------------------------------------------------------------------------------

  func startRecording() {
    let node = audioEngine.inputNode
    let recordingFormat = node.outputFormat(forBus: 0)

    node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, _) in
      self.request.append(buffer)
    }

    audioEngine.prepare()
    do {
      try audioEngine.start()
    } catch let error {
      print("Error")
    }

    guard let myRecognization = SFSpeechRecognizer() else {
      return
    }
    task = speechReconizer?.recognitionTask(with: request, resultHandler: { (response, error) in
      guard let response = response else { return }
      let message = response.bestTranscription.formattedString
      var lastString: String = ""
      for segment in response.bestTranscription.segments {
        let indexTo = message.index(message.startIndex, offsetBy: segment.substringRange.location)
        lastString = String(message[indexTo...])
      }
      switch lastString {
      case "ação":
        print("Ação")
      case "subi":
        print("Subi")
      case "descer":
        print("Descer")
      default:
        print(lastString)
      }
    })
  }

}
