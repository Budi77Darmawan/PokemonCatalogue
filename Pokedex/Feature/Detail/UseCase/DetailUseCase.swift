//
//  DetailUseCase.swift
//  Pokedex
//
//  Created by Budi Darmawan on 24/10/22.
//

import Foundation
import RxSwift

protocol DetailUseCaseProtocol {
    func getPokemonInCollection(pokemonId: Int) -> Observable<Bool>
    func addToCollection(pokemon: PokemonModel) -> Observable<Bool>
    func deleteFromCollection(pokemonId: Int) -> Observable<Bool>
}

class DetailUseCase: DetailUseCaseProtocol {
    private let pokemonRepository: PokemonRepositoryProtocol
    
    init(repository: PokemonRepositoryProtocol) {
        self.pokemonRepository = repository
    }
    
    func getPokemonInCollection(pokemonId: Int) -> Observable<Bool> {
        return self.pokemonRepository.getPokemonInCollection(pokemonId: pokemonId)
    }
    
    func addToCollection(pokemon: PokemonModel) -> Observable<Bool> {
        return self.pokemonRepository.addToCollection(pokemon: pokemon)
    }
    
    func deleteFromCollection(pokemonId: Int) -> Observable<Bool> {
        return self.pokemonRepository.deleteFromCollection(pokemonId: pokemonId)
    }
}
