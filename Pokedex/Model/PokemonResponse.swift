//
//  PokemonResponse.swift
//  Pokedex
//
//  Created by iOS Buaya on 12/10/22.
//

import Foundation

// MARK: - PokemonResponse
struct ListPokemonResponse: Decodable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [BasicResponse]?
}

struct PokemonResponse: Decodable {
    let abilities: [Ability]?
    let id: Int?
    let name: String?
    let species: BasicResponse?
    let stats: [Stat]?
    let types: [Types]?
    let moves: [Moves]?
    let height: Int?
    let weight: Int?
    
    var imageUri: String {
        get {
            return "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(id ?? 0).png"
        }
    }
}

struct Ability: Codable {
    let ability: BasicResponse?
    let isHidden: Bool?
    let slot: Int?
    
    enum CodingKeys: String, CodingKey {
        case ability, slot
        case isHidden = "is_hidden"
    }
}

struct Stat: Codable {
    let baseStat: Int?
    let effort: Int?
    let stat: BasicResponse?
    
    enum CodingKeys: String, CodingKey {
        case effort, stat
        case baseStat = "base_stat"
    }
}

struct Types: Codable {
    let slot: Int?
    let type: BasicResponse?
}

struct Moves: Codable {
    let move: BasicResponse?
}
