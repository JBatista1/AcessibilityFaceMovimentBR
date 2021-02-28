//
//  TimerActionProtocol.swift
//  AcessibilityFaceMovimentBR
//
//  Created by Joao Batista on 06/02/21.
//  Copyright © 2021 Joao Batista. All rights reserved.
//

import Foundation

protocol TimerActionResponseProtocol: AnyObject {
  func finishTimer()
  func canceledTimer()
}

protocol TimerActionProtocol {
  func startTimer(withTimerSeconds seconds: Int)
  func stopTimer()
}
