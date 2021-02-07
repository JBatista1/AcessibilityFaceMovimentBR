//
//  UIVIew+Position.swift
//  Commons
//
//  Created by Joao Batista on 20/10/20.
//  Copyright © 2020 Joao Batista. All rights reserved.
//

import UIKit

extension UIView {

    func absoluteValueToPositionCenter() -> CGPoint {
        let rootView = UIApplication.shared.keyWindow?.rootViewController?.view
        guard let absoluteCenter  = self.superview?.convert(self.center, to: rootView) else { return CGPoint(x: 0, y: 0)}
        return absoluteCenter
    }

    func absoluteValueToFrame() -> CGRect {
        let rootView = UIApplication.shared.keyWindow?.rootViewController?.view
        guard let absoluteframe = self.superview?.convert(self.frame, to: rootView) else { return CGRect(x: 0, y: 0, width: 0, height: 0)}
        return absoluteframe
    }
}
