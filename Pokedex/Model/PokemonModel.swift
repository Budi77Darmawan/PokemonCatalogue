//
//  PokemonModel.swift
//  Pokedex
//
//  Created by iOS Buaya on 12/10/22.
//

import Foundation

struct PokemonModel {
    let id: Int?
    let name: String?
    let speciesId: Int?
    let imageUri: String?
    var type: [String]?
    var stat: [Stat]?
}

extension PokemonModel {
    var tag: String {
        get {
            guard let id = id else { return "###" }
            switch String(id).count {
            case 1: return "#00\(id)"
            case 2: return "#0\(id)"
            default: return "#\(id)"
            }
        }
    }
}
