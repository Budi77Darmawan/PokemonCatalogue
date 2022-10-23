//
//  HomeUseCase.swift
//  Pokedex
//
//  Created by Budi Darmawan on 20/10/22.
//

import Foundation
import RxSwift

protocol HomeUseCaseProtocol {
    func getListPokemonIds(page: Int) -> Observable<[Int]>
    func getPokemonDetails(id: Int) -> Observable<PokemonModel>
}

class HomeUseCase: HomeUseCaseProtocol {
    private let pokemonRepository: PokemonRepositoryProtocol
    
    init(repository: PokemonRepositoryProtocol) {
        self.pokemonRepository = repository
    }
    
    func getListPokemonIds(page: Int) -> Observable<[Int]> {
        return self.pokemonRepository.getListPokemonIds(page: page)
    }
    
    
    func getPokemonDetails(id: Int) -> Observable<PokemonModel> {
        return self.pokemonRepository.getPokemonDetails(id: id)
    }
}
