//
//  PokemonTableViewCell.swift
//  Pokedex
//
//  Created by Budi Darmawan on 24/10/22.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {

    public static let identifier = "PokemonTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "PokemonTableViewCell",
                     bundle: nil)
    }
    
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonTypesLabel: UILabel!
    @IBOutlet weak var pokemonImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(_ pokemon: PokemonModel?) {
        var name = pokemon?.name?.capitalized
        if !(pokemon?.nickName?.isEmpty == true) {
            name = "\(name ?? "") (\(pokemon?.nickName ?? "-"))"
        }
        pokemonNameLabel.text = name
        pokemonTypesLabel.text = pokemon?.types?.joined(separator: ", ")
        pokemonImageView.loadImage(uri: pokemon?.imageUri,
                                   placeholder: getUIImage(named: "pokeball"))
    }
    
}
