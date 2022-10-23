//
//  ObjPokemonModel.swift
//  Pokedex
//
//  Created by Budi Darmawan on 24/10/22.
//

import Foundation
import RealmSwift

class ObjPokemonModel: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var nickname: String = ""
    @objc dynamic var speciesId: Int = 0
    @objc dynamic var imageUri: String = ""
    @objc dynamic var height: Int = 0
    @objc dynamic var weight: Int = 0
    @objc dynamic var isCatched: Bool = false
    
    var types: List<String> = List()
    var moves: List<String> = List()
    var abilities: List<String> = List()
    var stats: List<ObjStat> = List()
    
    override class func primaryKey() -> String? {
        return "id"
    }
}

class ObjStat: Object {
    @objc dynamic var baseStat: Int = 0
    @objc dynamic var stat: ObjBaseResponse? = nil
    
    convenience init(baseStat: Int?, stat: ObjBaseResponse?) {
        self.init()
        self.baseStat = baseStat ?? 0
        self.stat = stat
    }
}

class ObjBaseResponse: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var url: String = ""
    
    convenience init(name: String?, url: String?) {
        self.init()
        self.name = name ?? ""
        self.url = url ?? ""
    }
}
