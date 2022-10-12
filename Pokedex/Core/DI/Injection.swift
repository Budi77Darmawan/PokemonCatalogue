//
//  Injection.swift
//  Pokedex
//
//  Created by Budi Darmawan on 21/10/22.
//

import Foundation

final class Injection {
    func provideHomeUseCase() -> HomeUseCaseProtocol {
        let remoteRepo = provideRepository()
        return HomeUseCase(repository: remoteRepo)
    }
}

extension Injection {
    private func provideRepository() -> PokemonRepositoryProtocol {
        let remoteDataSource = RemoteDataSource()
        return PokemonRepository.sharedInstance(remoteDataSource)
    }
}
