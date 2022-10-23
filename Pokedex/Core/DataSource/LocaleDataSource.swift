//
//  LocaleDataSource.swift
//  Pokedex
//
//  Created by Budi Darmawan on 24/10/22.
//

import Foundation
import RxSwift
import RealmSwift

protocol LocaleDataSourceProtocol: AnyObject {
    func getPokemonInCollection(pokemonId: Int) -> Observable<Bool>
    func addToCollection(pokemon: ObjPokemonModel) -> Observable<Bool>
    func deleteFromCollection(pokemonId: Int) -> Observable<Bool>
}

final class LocaleDataSource: NSObject {
    private let realm: Realm?
    
    private init(realm: Realm?) {
        self.realm = realm
    }
    
    static let sharedInstance: (Realm?) -> LocaleDataSource = { realmDB in
        return LocaleDataSource(realm: realmDB)
    }
}

extension LocaleDataSource: LocaleDataSourceProtocol {
    
    func getPokemonInCollection(pokemonId: Int) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            if let realm = self.realm {
                let pokemonDB = realm.objects(ObjPokemonModel.self)
                let pokemon = pokemonDB.first(where: { $0.id == pokemonId })
                pokemon == nil ? observer.onNext(false) : observer.onNext(true)
                observer.onCompleted()
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            return Disposables.create()
        }
    }
    
    func addToCollection(pokemon: ObjPokemonModel) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            if let realm = self.realm {
                do {
                    try realm.write {
                        pokemon.isCatched = true
                        realm.add(pokemon)
                        observer.onNext(true)
                        observer.onCompleted()
                    }
                } catch {
                    observer.onError(DatabaseError.requestFailed)
                }
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            return Disposables.create()
        }
    }
    
    func deleteFromCollection(pokemonId: Int) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            if let realm = self.realm {
                do {
                    let pokemonDB = realm.objects(ObjPokemonModel.self)
                    let pokemon = pokemonDB.first(where: { $0.id == pokemonId })
                    if pokemon == nil {
                        observer.onNext(true)
                        observer.onCompleted()
                    } else {
                        try realm.write {
                            realm.delete(pokemon!)
                            observer.onNext(true)
                            observer.onCompleted()
                        }
                    }
                } catch {
                    observer.onError(DatabaseError.requestFailed)
                }
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            return Disposables.create()
        }
    }
}

enum DatabaseError: LocalizedError {
    case invalidInstance
    case requestFailed
    
    var errorDescription: String? {
        switch self {
        case .invalidInstance: return "Database can't instance."
        case .requestFailed: return "Your request failed."
        }
    }
    
}
