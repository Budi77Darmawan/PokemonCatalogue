//
//  PokemonSpeciesResponse.swift
//  Pokedex
//
//  Created by iOS Buaya on 12/10/22.
//

import Foundation

struct PokemonSpeciesResponse {
    let id: Int?
    let name: String?
    let color: BasicResponse?
    let varieties: [Varieties]?
}

struct Varieties {
    let pokemon: BasicResponse?
}
