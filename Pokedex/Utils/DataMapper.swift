//
//  DataMapper.swift
//  Pokedex
//
//  Created by Budi Darmawan on 24/10/22.
//

import Foundation
import RealmSwift

final class DataMapper {
    static func mapPokemonResponseToModel(data: PokemonResponse) -> PokemonModel {
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
    
    static func mapPokemonModelToObj(data: PokemonModel) -> ObjPokemonModel {
        let result = ObjPokemonModel()
        result.id = data.id ?? 0
        result.name = data.name ?? ""
        result.nickname = data.nickName ?? ""
        result.speciesId = data.speciesId ?? 0
        result.imageUri = data.imageUri ?? ""
        result.height = data.height ?? 0
        result.weight = data.weight ?? 0
        data.types?.forEach { result.types.append($0) }
        data.moves?.forEach { result.moves.append($0) }
        data.abilities?.forEach { result.abilities.append($0) }
        let stats: List<ObjStat> = List()
        data.stats?.forEach {
            let stat = ObjBaseResponse(name: $0.stat?.name, url: $0.stat?.url)
            let objStat = ObjStat(baseStat: $0.baseStat, stat: stat)
            stats.append(objStat)
        }
        result.stats = stats
        return result
    }
    
    static func mapListObjPokemonToListModel(array: Results<ObjPokemonModel>) -> [PokemonModel] {
        return array.map {
            mapObjPokemonToModel(data: $0)
        }
    }
    
    static func mapObjPokemonToModel(data: ObjPokemonModel) -> PokemonModel {
        let types: [String] = data.types.map { $0 }
        let moves: [String] = data.moves.map { $0 }
        let abilities: [String] = data.abilities.map { $0 }
        let stats: [Stat] = data.stats.map {
            Stat(baseStat: $0.baseStat, effort: 0, stat: BasicResponse(name: $0.stat?.name, url: $0.stat?.url))
        }
        return PokemonModel(id: data.id, name: data.name, speciesId: data.speciesId, imageUri: data.imageUri, height: data.height, weight: data.weight, types: types, moves: moves, stats: stats, abilities: abilities, nickName: data.nickname)
    }
}
