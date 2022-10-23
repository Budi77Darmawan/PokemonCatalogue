//
//  Collection+Ext.swift
//  Pokedex
//
//  Created by Budi Darmawan on 21/10/22.
//

import Foundation

extension Collection where Indices.Iterator.Element == Index {
    subscript (safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
