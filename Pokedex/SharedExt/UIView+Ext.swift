//
//  UIView+Ext.swift
//  Pokedex
//
//  Created by Budi Darmawan on 23/10/22.
//

import Foundation
import UIKit

extension UIView {
    func setTopCorners(_ radius: CGFloat) {
        let corners = UIRectCorner(arrayLiteral: [
            UIRectCorner.topLeft,
            UIRectCorner.topRight
        ])
        
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
        layer.masksToBounds = true
    }
    
    func setCornersRadius(_ radius: CGFloat) {
        self.layer.cornerRadius = radius
    }
    
}

