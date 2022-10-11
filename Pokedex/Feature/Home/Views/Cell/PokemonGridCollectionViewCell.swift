//
//  PokemonGridCollectionViewCell.swift
//  Pokedex
//
//  Created by Budi Darmawan on 11/10/22.
//

import UIKit

class PokemonGridCollectionViewCell: UICollectionViewCell {
    
    public static let identifier = "PokemonGridCollectionViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "PokemonGridCollectionViewCell",
                     bundle: nil)
    }
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonTagLabel: UILabel!
    @IBOutlet weak var containerAttribute1View: UIView!
    @IBOutlet weak var pokemonAttribute1Label: UILabel!
    @IBOutlet weak var containerAttribute2View: UIView!
    @IBOutlet weak var pokemonAttribute2Label: UILabel!
    @IBOutlet weak var pokemonImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
