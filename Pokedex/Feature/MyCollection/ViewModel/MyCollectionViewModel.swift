//
//  MyCollectionViewModel.swift
//  Pokedex
//
//  Created by Budi Darmawan on 24/10/22.
//

import Foundation
import RxSwift
import RxCocoa

class MyCollectionViewModel: BaseViewModel {
    private let disposeBag = DisposeBag()
    private let myCollectionUseCase: MyCollectionUseCaseProtocol
    
    private let _pokemons = BehaviorRelay<[PokemonModel]>(value: [])
    
    init(useCase: MyCollectionUseCaseProtocol) {
        myCollectionUseCase = useCase
        super.init()
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
    
    
    func getCollection() {
        myCollectionUseCase.getCollection()
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                self._pokemons.accept(result)
            } onError: { error in
                self._errorMessage.accept(error.localizedDescription)
            }
            .disposed(by: disposeBag)
    }
}
