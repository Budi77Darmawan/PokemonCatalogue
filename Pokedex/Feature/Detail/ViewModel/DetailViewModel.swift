//
//  DetailViewModel.swift
//  Pokedex
//
//  Created by Budi Darmawan on 24/10/22.
//

import Foundation
import RxSwift
import RxCocoa

class DetailViewModel: BaseViewModel {
    private let disposeBag = DisposeBag()
    private let detailUseCase: DetailUseCaseProtocol
    
    private let _isCatched = BehaviorRelay<Bool>(value: false)
    private let _pokemon = BehaviorRelay<PokemonModel?>(value: nil)
    
    init(useCase: DetailUseCaseProtocol, pokemon: PokemonModel?) {
        detailUseCase = useCase
        _pokemon.accept(pokemon)
        super.init()
        self.getStatusPokemonInCollection(pokemonId: pokemon?.id)
    }
    
    var pokemon: Driver<PokemonModel?> {
        return _pokemon.asDriver()
    }
    
    var isCatched: Driver<Bool> {
        return _isCatched.asDriver()
    }
    
    private func getStatusPokemonInCollection(pokemonId: Int?) {
        guard let pokemonId = pokemonId else { return }
        detailUseCase.getPokemonInCollection(pokemonId: pokemonId)
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                self._isCatched.accept(result)
            } onError: { error in
                self._errorMessage.accept(error.localizedDescription)
            }
            .disposed(by: disposeBag)
    }
    
    func addToCollection(nickName: String) {
        guard var pokemon = _pokemon.value else { return }
        pokemon.nickName = nickName
        detailUseCase.addToCollection(pokemon: pokemon)
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                self._isCatched.accept(result)
            } onError: { error in
                self._errorMessage.accept(error.localizedDescription)
            }
            .disposed(by: disposeBag)
    }
    
    func deleteFromCollection() {
        guard let pokemonId = _pokemon.value?.id else { return }
        detailUseCase.deleteFromCollection(pokemonId: pokemonId)
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                self._isCatched.accept(!result)
            } onError: { error in
                self._errorMessage.accept(error.localizedDescription)
            }
            .disposed(by: disposeBag)
    }
}
