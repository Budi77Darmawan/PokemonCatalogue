//
//  AppColor.swift
//  Pokedex
//
//  Created by Budi Darmawan on 23/10/22.
//

import Foundation
import UIKit

private enum AppColor: String {
    case primaryColor
}

extension UIColor {
    
    private static func defaultColor(named name: AppColor, default defaultColor: UIColor = .black) -> UIColor {
        return UIColor(named: name.rawValue) ?? defaultColor
    }
    
    public class var primaryColor: UIColor {
        return defaultColor(named: .primaryColor)
    }
}
