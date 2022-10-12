//
//  UIImageView+Ext.swift
//  Pokedex
//
//  Created by Budi Darmawan on 20/10/22.
//

import Foundation
import SDWebImage

extension UIImageView {
    func loadImage(uri: String?, placeholder: UIImage? = nil) {
        guard let uri = uri, let uriImage = URL(string: uri) else { return }
        self.sd_setImage(with: uriImage, placeholderImage: placeholder)
    }
}

extension UIView {
    func getUIImage(named: String) -> UIImage {
        return UIImage(named: named) ?? UIImage(systemName: "minus.circle.fill")!
    }
}
