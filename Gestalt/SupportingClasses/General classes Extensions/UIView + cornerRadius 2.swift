//
//  UIView + cornerRadius.swift
//  Gestalt
//
//  Created by Alexey Chekanov on 5/18/17.
//  Copyright © 2017 Alexey Chekanov. All rights reserved.
//

import UIKit

extension UIView {
    
    /// SwifterSwift: Set some or all corners radiuses of view.
    ///
    /// - Parameters:
    ///   - corners: array of corners to change (example: [.bottomLeft, .topRight]).
    ///   - radius: radius for selected corners.
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: bounds,
                                    byRoundingCorners: corners,
                                    cornerRadii: CGSize(width: radius, height: radius))
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        layer.mask = shape
        
    }
}
