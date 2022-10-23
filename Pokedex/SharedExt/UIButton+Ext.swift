//
//  UIButton+Ext.swift
//  Pokedex
//
//  Created by Budi Darmawan on 23/10/22.
//

import Foundation
import UIKit

extension UIButton {
    func disable() {
        self.isEnabled = false
    }
    
    func enabled() {
        self.isEnabled = true
    }
}
