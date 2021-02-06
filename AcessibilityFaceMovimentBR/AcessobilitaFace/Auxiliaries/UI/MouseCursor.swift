//
//  MouseCursor.swift
//  AcessibilityFaceMovimentBR
//
//  Created by Joao Batista on 06/02/21.
//  Copyright © 2021 Joao Batista. All rights reserved.
//

import UIKit

class MouseCursor: UIImageView {

  private let shapeLayer = CAShapeLayer()

  func createTimer() {
    let gradientLayer = CAGradientLayer()
    gradientLayer.type = .conic
    gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.5)
    gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
    gradientLayer.colors = [UIColor.red, UIColor.blue].map({$0.cgColor})

    //Criando circulo
    let center = CGPoint(x: 30, y: 30)
    
    let circularPath = UIBezierPath(arcCenter: center,
                                    radius: 10,
                                    startAngle: -CGFloat.pi / 2,
                                    endAngle: 2 * CGFloat.pi ,
                                    clockwise: true)
    shapeLayer.path = circularPath.cgPath
    //Criando contorno
    
    shapeLayer.strokeColor = UIColor.blue.cgColor
    shapeLayer.lineWidth = 8
    shapeLayer.fillColor = UIColor.clear.cgColor

    shapeLayer.strokeEnd = 0
    shapeLayer.lineCap = .round

    self.layer.addSublayer(shapeLayer)
  }
  
  func startAnimitionTimer() {
    let basicAniamtion = CABasicAnimation(keyPath: "strokeEnd")
    basicAniamtion.toValue = 1
    basicAniamtion.duration = 2
    basicAniamtion.fillMode = .forwards
    basicAniamtion.isRemovedOnCompletion = false

    shapeLayer.add(basicAniamtion, forKey: "urSoBasic")
  }
}
