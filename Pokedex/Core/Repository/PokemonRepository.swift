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
}

final class PokemonRepository: NSObject {
    
    typealias PokemonInstance = (RemoteDataSource) -> PokemonRepository
    fileprivate let remote: RemoteDataSource
    
    private init(remoteDataSource: RemoteDataSource) {
        self.remote = remoteDataSource
    }
    
    static let sharedInstance: PokemonInstance = { remoteData in
        return PokemonRepository(remoteDataSource: remoteData)
    }
    
}

extension PokemonRepository: PokemonRepositoryProtocol {
    func getListPokemonIds(page: Int) -> Observable<[Int]> {
        return self.remote.getListPokemon(page: page)
            .map { $0.results?.map { $0.id } ?? [] }
    }
    
    func getPokemonDetails(id: Int) -> Observable<PokemonModel> {
        return self.remote.getPokemonDetails(id: id)
            .map { self.mapPokemonResponseToModel(data: $0) }
    }
    
    private func mapPokemonResponseToModel(data: PokemonResponse) -> PokemonModel {
        return PokemonModel(
            id: data.id,
            name: data.name,
            speciesId: data.species?.id,
            imageUri: data.imageUri,
            height: data.height,
            weight: data.weight,
            types: data.types?.map { $0.type?.name ?? "" },
            moves: data.moves?.map { $0.move?.name ?? "" },
            stats: data.stats,
            abilities: data.abilities?.map { $0.ability?.name ?? ""}
        )
    }
}
