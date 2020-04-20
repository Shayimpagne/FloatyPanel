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
    
    func bindViewFrameToSuperviewBounds(top: CGFloat = 0, left: CGFloat = 0, bottom: CGFloat = 0, right: CGFloat = 0) {
        guard let superview = superview else {
            return
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: superview.topAnchor, constant: top).isActive = true
        superview.bottomAnchor.constraint(equalTo: bottomAnchor, constant: bottom).isActive = true
        leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: left).isActive = true
        superview.trailingAnchor.constraint(equalTo: trailingAnchor, constant: right).isActive = true
    }
}
