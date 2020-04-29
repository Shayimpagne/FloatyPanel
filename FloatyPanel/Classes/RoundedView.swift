//
//  RoundedView.swift
//  FloatyPanel
//
//  Created by Emir Shayymov on 4/27/20.
//

import Foundation

open class RoundedView: UIView {

    override open func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = bounds.height / 2
    }

}
