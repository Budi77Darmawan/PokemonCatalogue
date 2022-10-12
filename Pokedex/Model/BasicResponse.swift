//
//  BasicResponse.swift
//  Pokedex
//
//  Created by iOS Buaya on 12/10/22.
//

import Foundation

// MARK: - BasicResponse
struct BasicResponse: Codable {
    let name: String?
    let url: String?
}

extension BasicResponse {
    var id: Int {
        get {
            guard let url = self.url else { return 0 }
            let id = url.split(separator: "/").filter { !$0.isEmpty }
            return Int(id.last ?? "0") ?? 0
        }
    }
    
    var imageUri: String {
        get {
            return "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(self.id).png"
        }
    }
}
