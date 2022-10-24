//
//  MyCollectionUseCase.swift
//  Pokedex
//
//  Created by Budi Darmawan on 24/10/22.
//

import Foundation
import RxSwift

protocol MyCollectionUseCaseProtocol {
    func getCollection() -> Observable<[PokemonModel]>
}

class MyCollectionUseCase: MyCollectionUseCaseProtocol {
    private let pokemonRepository: PokemonRepositoryProtocol
    
    init(repository: PokemonRepositoryProtocol) {
        self.pokemonRepository = repository
    }
    
    func getCollection() -> Observable<[PokemonModel]> {
        return self.pokemonRepository.getCollection()
    }
}
