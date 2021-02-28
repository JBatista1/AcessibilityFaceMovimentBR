//
//  ManagerPointSesibilittyProtocol.swift
//  AcessibilityFaceMovimentBR
//
//  Created by Joao Batista on 28/02/21.
//  Copyright © 2021 Joao Batista. All rights reserved.
//

import UIKit

protocol ManagerPointSesibilittyProtocol: AnyObject {
  func startCaptura()
  func returnCapture(theValue value: CGFloat)
}
