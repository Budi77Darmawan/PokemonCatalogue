//
//  Injection.swift
//  Pokedex
//
//  Created by Budi Darmawan on 21/10/22.
//

import Foundation
import RealmSwift

final class Injection {
    func provideHomeUseCase() -> HomeUseCaseProtocol {
        let remoteRepo = provideRepository()
        return HomeUseCase(repository: remoteRepo)
    }
    
    func provideDetailUeCase() -> DetailUseCaseProtocol {
        let remoteRepo = provideRepository()
        return DetailUseCase(repository: remoteRepo)
    }
}

extension Injection {
    private func provideRepository() -> PokemonRepositoryProtocol {
        let realm = try? Realm()
        let localDataSource = LocaleDataSource.sharedInstance(realm)
        let remoteDataSource = RemoteDataSource()
        return PokemonRepository.sharedInstance(remoteDataSource, localDataSource)
    }
}
