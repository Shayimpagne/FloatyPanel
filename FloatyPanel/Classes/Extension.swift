//
//  Extension.swift
//  FloatyPanel
//
//  Created by Emir Shayymov on 4/17/20.
//  Copyright © 2020 Shayimpagne. All rights reserved.
//

import Foundation
import UIKit 

extension UIView {
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
