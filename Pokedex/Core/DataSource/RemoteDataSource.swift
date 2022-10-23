//
//  RemoteDataSource.swift
//  Pokedex
//
//  Created by iOS Buaya on 12/10/22.
//

import Foundation
import RxSwift


final class RemoteDataSource {
    func getListPokemon(page: Int) -> Observable<ListPokemonResponse> {
        let limit = 20
        let offset = (page-1) * limit
        let url = URL(string: ConstServices.baseURL + "pokemon?limit=\(limit)&offset=\(offset)")!
        let data: Observable<ListPokemonResponse> = APIManager.shared.executeQuery(url: url, method: .get, params: nil)
        return data
    }
    
    func getPokemonDetails(id: Int) -> Observable<PokemonResponse> {
        let url = URL(string: ConstServices.baseURL + "pokemon/\(id)")!
        let data: Observable<PokemonResponse> = APIManager.shared.executeQuery(url: url, method: .get, params: nil)
        return data
    }
}
