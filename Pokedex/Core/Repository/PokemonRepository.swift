//
//  PokemonRepository.swift
//  Pokedex
//
//  Created by iOS Buaya on 12/10/22.
//

import Foundation
import RxSwift

protocol PokemonRepositoryProtocol {
    func getListPokemonIds(page: Int) -> Observable<[Int]>
    func getPokemonDetails(id: Int) -> Observable<PokemonModel>
    func getPokemonInCollection(pokemonId: Int) -> Observable<Bool>
    func addToCollection(pokemon: PokemonModel) -> Observable<Bool>
    func deleteFromCollection(pokemonId: Int) -> Observable<Bool>
}

final class PokemonRepository: NSObject {
    
    typealias PokemonInstance = (RemoteDataSource, LocaleDataSource) -> PokemonRepository
    fileprivate let remote: RemoteDataSource
    fileprivate let locale: LocaleDataSource
    
    private init(remoteDataSource: RemoteDataSource, localeDataSource: LocaleDataSource) {
        self.remote = remoteDataSource
        self.locale = localeDataSource
    }
    
    static let sharedInstance: PokemonInstance = { remote, local in
        return PokemonRepository(remoteDataSource: remote, localeDataSource: local)
    }
    
}

extension PokemonRepository: PokemonRepositoryProtocol {
    func getListPokemonIds(page: Int) -> Observable<[Int]> {
        return self.remote.getListPokemon(page: page)
            .map { $0.results?.map { $0.id } ?? [] }
    }
    
    func getPokemonDetails(id: Int) -> Observable<PokemonModel> {
        return self.remote.getPokemonDetails(id: id)
            .map { DataMapper.mapPokemonResponseToModel(data: $0) }
    }
    
    func getPokemonInCollection(pokemonId: Int) -> Observable<Bool> {
        return self.locale.getPokemonInCollection(pokemonId: pokemonId)
    }
    
    func addToCollection(pokemon: PokemonModel) -> Observable<Bool> {
        return locale.addToCollection(pokemon: DataMapper.mapPokemonModelToObj(data: pokemon))
    }
    
    func deleteFromCollection(pokemonId: Int) -> Observable<Bool> {
        return locale.deleteFromCollection(pokemonId: pokemonId)
    }
    
    
}
