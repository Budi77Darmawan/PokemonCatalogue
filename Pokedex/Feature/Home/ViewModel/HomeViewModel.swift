//
//  HomeViewModel.swift
//  Pokedex
//
//  Created by Budi Darmawan on 20/10/22.
//

import Foundation
import RxSwift
import RxCocoa

class HomeViewModel: BaseViewModel {
    private let disposeBag = DisposeBag()
    private let homeUseCase: HomeUseCaseProtocol
    
    private var pokemonResults = [PokemonModel]()
    private var pokemonResultsCount = 0
    private var page = 1
    private var isLoadNextPage = false
    
    
    private let _pokemons = BehaviorRelay<[PokemonModel]>(value: [])
    
    init(useCase: HomeUseCaseProtocol) {
        homeUseCase = useCase
        super.init()
        getListPokemon()
    }
    
    var pokemons: Driver<[PokemonModel]> {
        return _pokemons.asDriver()
    }
    
    var pokemonsCount: Int {
        return _pokemons.value.count
    }
    
    func pokemon(at index: Int) -> PokemonModel? {
        return _pokemons.value[safe: index]
    }
    
    func refresh() {
        pokemonResults = []
        pokemonResultsCount = 0
        page = 1
        getListPokemon()
    }
    
    private var isSearch: Bool {
        return _pokemons.value.count <= pokemonResultsCount - 1
    }
    
    func getNextPage(index: Int) {
        if !isLoadNextPage && !isSearch {
            if _pokemons.value.count - 3 == index {
                isLoadNextPage = true
                getListPokemon()
            }
        }
    }
    
    func getListPokemon() {
        homeUseCase.getListPokemonIds(page: page)
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                self.pokemonResultsCount += result.count
                result.forEach { id in
                    self.getPokemonDetail(id: id)
                }
            } onError: { error in
                self._errorMessage.accept(error.localizedDescription)
            }
            .disposed(by: disposeBag)
    }
    
    func getPokemonDetail(id: Int) {
        homeUseCase.getPokemonDetails(id: id)
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                self.pokemonResults.append(result)
                if self.pokemonResults.count == self.pokemonResultsCount {
                    self.page += 1
                    self.isLoadNextPage = false
                    self._pokemons.accept(self.pokemonResults.sorted { $0.id ?? 0 < $1.id ?? 0})
                }
            }
            .disposed(by: disposeBag)
    }
    
    func searchPokemons(with query: String?) {
        guard let query = query, !query.isEmpty else {
            _pokemons.accept(pokemonResults)
            return
        }
        let filterPokemon = pokemonResults.filter { ($0.name?.lowercased().contains(query.lowercased())) == true }
        _pokemons.accept(filterPokemon)
    }
    
}
